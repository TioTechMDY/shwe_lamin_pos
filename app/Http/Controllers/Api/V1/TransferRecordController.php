<?php

namespace App\Http\Controllers\Api\V1;

use App\CPU\Helpers;
use App\Models\EditTransferRecordDetail;
use App\Models\ProductNew;
use App\Models\Shop;
use App\Models\Tank;
use App\Models\TransferRecord;
use App\Models\EditTransferRecord;
use Box\Spout\Common\Exception\InvalidArgumentException;
use Box\Spout\Common\Exception\IOException;
use Box\Spout\Common\Exception\UnsupportedTypeException;
use Box\Spout\Writer\Exception\WriterNotOpenedException;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\Request;
use App\Http\Controllers\Controller;
use Illuminate\Support\Facades\Validator;
use Rap2hpoutre\FastExcel\FastExcel;
use Illuminate\Support\Facades\Auth;
use Symfony\Component\HttpFoundation\StreamedResponse;
use function App\CPU\translate;

class TransferRecordController extends Controller
{
    public function __construct(
        private TransferRecord $transferRecord,
        private ProductNew $productNew,
        private Tank $tank,
    ){}

    public function createTransferRecord(Request $request)
    {

        $productRaw = $request->input('product_news');
        $products = json_decode($productRaw, true);
        if (!is_array($products)) {
            return response()->json(['error' => $products], 400);
        }

        $extraProductRaw = $request->input('extra_product_news');
        $extraProducts = json_decode($extraProductRaw, true);
        if (!is_array($extraProducts)) {
            return response()->json(['error' => $extraProducts], 400);
        }
        $fromId = $request->input('from_id'); // Get the tag from the request
        $from = $request->input('from_type');
        $toId = $request->input('to_id'); // Get the tag from the request
        $isFinal = $request->input('isFinal'); // Get the tag from the request
        $extraDescription = $request->input('extra_description',''); // Get the tag from the request

        $to = $request->input('to_type');
        if($from == 'shop'){
            $fromType = 1;
            $fromShop = Shop::find($fromId);
        }else{
            $fromType = 2;
            $fromTank = Tank::find($fromId);
        }
        if($to == 'shop'){
            $toType = 1;
        }else{
            $toType = 2;
        }
        if(intval($toId)==20){
            $status = 'confirmed';
        }else{
            $status = 'pending';
        }
        $createdBy = Auth::id();



        $transferRecord = TransferRecord::create(
            [
                'from_id' => intval($fromId),
                'from_type'=> $fromType,
                'to_id'=>intval($toId),
                'to_type'=>$toType,
                'isFinal'=>intval($isFinal),
                'status' => $status,
                'extra_description' => $extraDescription??'',
                'created_by' => $createdBy,
            ]
        );

        foreach ($products as $product_new) {
            $transferRecord->productNews()->attach($product_new['product_new_id'], ['quantity' => $product_new['quantity'], 'isExtra' => 0]);
        }

        foreach ($extraProducts as $product_new) {
            $transferRecord->productNews()->attach($product_new['product_new_id'], ['quantity' => $product_new['quantity'], 'isExtra' => 1]);
        }



        foreach ($products as $product_new) {

            if($from == 'shop'){
                $senderCurrentQuantity = $fromShop->product_news()->where('product_new_id', $product_new['product_new_id'])->first()->pivot->absolute;
                $newQuantity = intval($senderCurrentQuantity) - intval($product_new['quantity']);
                $fromShop->product_news()->updateExistingPivot($product_new['product_new_id'], [
                    'absolute' => $newQuantity,
                ]);

            }else{
                $senderCurrentQuantity = $fromTank->productNews()->where('product_new_id', $product_new['product_new_id'])->first()->pivot->quantity;
                $newSenderQuantity = $senderCurrentQuantity - $product_new['quantity'];
                $fromTank->productNews()->updateExistingPivot($product_new['product_new_id'], [
                    'quantity' => $newSenderQuantity,
                ]);
            }

        }



        return response()->json([
            'success' => true,
            'message' => translate('Transfer Record saved successfully'),
        ], 200);
    }

    public function update(Request $request)
    {
        // Validate the request data
        $request->validate([
            'id'=> 'required',
        ]);
        $actualProductRaw = $request->input('actual_product_news');
        $actualProducts = json_decode($actualProductRaw, true);
        if (!is_array($actualProducts)) {
            return response()->json(['error' => $actualProducts], 400);
        }
        $isFinal = $request->input('isFinal'); // Get the tag from the request

        $id = intval($request->id);
        $toId = $request->input('to_id'); // Get the tag from the request
        $toTank = Tank::find($toId);
        $updatedBy = Auth::id();


        $transferRecord = TransferRecord::findOrFail($id);
        foreach ($actualProducts as $product_new) {
            $transferRecord->productNews()->attach($product_new['product_new_id'], ['quantity' => $product_new['quantity'], 'isExtra' => 2]);
        }

        foreach ($actualProducts as $product_new) {


            if(intval($isFinal) == 0){
            if ($toTank->product_news()->where('product_new_id', $product_new['product_new_id'])->exists()) {
                $recieverCurrentQuantity = $toTank->productNews()->where('product_new_id', $product_new['product_new_id'])->first()->pivot->quantity;

                $newRecieverQuantity = $recieverCurrentQuantity + $product_new['quantity'];

                $toTank->productNews()->updateExistingPivot($product_new['product_new_id'], [
                    'quantity' => $newRecieverQuantity,
                ]);
            } else {
                $toTank->productNews()->attach($product_new['product_new_id'], ['quantity' => $product_new['quantity']]);
            }
        }
        else{
            if ($toTank->product_news()->where('product_new_id', $product_new['product_new_id'])->exists()) {
                $recieverCurrentQuantity = $toTank->productNews()->where('product_new_id', $product_new['product_new_id'])->first()->pivot->quantity;

//                    $newRecieverQuantity = $recieverCurrentQuantity + $product_new['quantity'];
                $newRecieverQuantity = $recieverCurrentQuantity + 0;


                $toTank->productNews()->updateExistingPivot($product_new['product_new_id'], [
                    'quantity' => $newRecieverQuantity,
                ]);
            } else {
                $toTank->productNews()->attach($product_new['product_new_id'], ['quantity' => 0]);
            }
        }
        }

        $transferRecord->status = 'confirmed';
        $transferRecord->confirmed_by = $updatedBy;
        $transferRecord->save();


        return response()->json([
            'success' => true,
            'message' => 'Transfer record updated successfully',
        ], 200);
    }

    public function editTransferRecord(Request $request)
    {
        $request->validate([
            'id'=> 'required',
        ]);
        $productNewRaw = $request->input('product_news');
        $productNews = json_decode($productNewRaw, true);
        if (!is_array($productNews)) {
            return response()->json(['error' => $productNews], 400);
        }
        $isFinal = $request->input('isFinal'); // Get the tag from the request

        $id = intval($request->id);
        $toId = $request->input('to_id'); // Get the tag from the request
        $toTank = Tank::find($toId);
        $adminId = Auth::id();


        $transferRecord = TransferRecord::findOrFail($id);
       $editTransferRecordId = EditTransferRecord::create([
                'transfer_record_id' => $transferRecord->id,
                'admin_id' => $adminId,
            ]);
        foreach ($productNews as $product_new) {
//            $transferRecord->productNews()->attach($product_new['product_new_id'], ['quantity' => $product_new['quantity'], 'isExtra' => 2]);
            // I want to update the quantity of the product_new_id in the transfer record to the new quantity that is_Extra is 2,







            $transferRecord->productNews()->wherePivot('isExtra',2)->updateExistingPivot($product_new['product_new_id'], [
                'quantity' => $product_new['new_quantity'],
            ]);
            EditTransferRecordDetail::create(
                [
                    'edit_transfer_record_id' => $editTransferRecordId->id,
                    'product_new_id' => $product_new['product_new_id'],
                    'old_quantity' => $product_new['old_quantity'],
                    'new_quantity' => $product_new['new_quantity'],
                ]
            );
//            EditTransferRecord::create([
//                'transfer_record_id' => $transferRecord->id,
//                'product_new_id' => $product_new['product_new_id'],
//                'old_quantity' => $product_new['old_quantity'],
//                'new_quantity' => $product_new['new_quantity'],
//                'admin_id' => $adminId,
//            ]);
        }

        foreach ($productNews as $product_new) {


            if(intval($isFinal) == 0){
                if ($toTank->product_news()->where('product_new_id', $product_new['product_new_id'])->exists()) {
                    $recieverCurrentQuantity = $toTank->productNews()->where('product_new_id', $product_new['product_new_id'])->first()->pivot->quantity;

                    $newRecieverQuantity = $recieverCurrentQuantity + $product_new['new_quantity'] -$product_new['old_quantity'];

                    $toTank->productNews()->updateExistingPivot($product_new['product_new_id'], [
                        'quantity' => $newRecieverQuantity,
                    ]);
                } else {
                    $toTank->productNews()->attach($product_new['product_new_id'], ['quantity' => $product_new['new_quantity']]);
                }
            }
            else{
                if ($toTank->product_news()->where('product_new_id', $product_new['product_new_id'])->exists()) {
                    $recieverCurrentQuantity = $toTank->productNews()->where('product_new_id', $product_new['product_new_id'])->first()->pivot->quantity;

//                    $newRecieverQuantity = $recieverCurrentQuantity + $product_new['quantity'];
                    $newRecieverQuantity = $recieverCurrentQuantity + 0;


                    $toTank->productNews()->updateExistingPivot($product_new['product_new_id'], [
                        'quantity' => $newRecieverQuantity,
                    ]);
                } else {
                    $toTank->productNews()->attach($product_new['product_new_id'], ['quantity' => 0]);
                }
            }
        }

//        $transferRecord->status = 'confirmed';
        $transferRecord->save();


        return response()->json([
            'success' => true,
            'message' => 'Transfer record updated successfully',
        ], 200);
    }
}
