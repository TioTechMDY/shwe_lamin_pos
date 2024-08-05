<?php

namespace App\Http\Controllers\Api\V1;

use App\CPU\Helpers;
use App\Models\ProductNew;
use App\Models\Shop;
use App\Models\Tank;
use App\Models\TransferRecord;
use Box\Spout\Common\Exception\InvalidArgumentException;
use Box\Spout\Common\Exception\IOException;
use Box\Spout\Common\Exception\UnsupportedTypeException;
use Box\Spout\Writer\Exception\WriterNotOpenedException;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\Request;
use App\Http\Controllers\Controller;
use Illuminate\Support\Facades\Validator;
use Rap2hpoutre\FastExcel\FastExcel;
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



        $transferRecord = TransferRecord::create(
            [
                'from_id' => intval($fromId),
                'from_type'=> $fromType,
                'to_id'=>intval($toId),
                'to_type'=>$toType,
                'isFinal'=>intval($isFinal),
                'status' => 'pending',
            ]
        );

        foreach ($products as $product_new) {
            $transferRecord->productNews()->attach($product_new['product_new_id'], ['quantity' => $product_new['quantity'], 'isExtra' => 0]);
        }

        foreach ($extraProducts as $product_new) {
            $transferRecord->productNews()->attach($product_new['product_new_id'], ['quantity' => $product_new['quantity'], 'isExtra' => 1]);
        }

        $toTank = Tank::find($toId);


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

        foreach ($extraProducts as $extra_product_new) {

            if(intval($isFinal)){
                if ($toTank->product_news()->where('product_new_id', $extra_product_new['product_new_id'])->exists()) {
                    $recieverCurrentQuantity = $toTank->productNews()->where('product_new_id', $extra_product_new['product_new_id'])->first()->pivot->quantity;

                    $newRecieverQuantity = $recieverCurrentQuantity + $extra_product_new['quantity'];

                    $toTank->productNews()->updateExistingPivot($extra_product_new['product_new_id'], [
                        'quantity' => $newRecieverQuantity,
                    ]);
                } else {
                    $toTank->productNews()->attach($extra_product_new['product_new_id'], ['quantity' => $extra_product_new['quantity']]);
                }
            }else{
                if ($toTank->product_news()->where('product_new_id', $extra_product_new['product_new_id'])->exists()) {
                    $recieverCurrentQuantity = $toTank->productNews()->where('product_new_id', $extra_product_new['product_new_id'])->first()->pivot->quantity;

                    $newRecieverQuantity = $recieverCurrentQuantity + 0;

                    $toTank->productNews()->updateExistingPivot($extra_product_new['product_new_id'], [
                        'quantity' => $newRecieverQuantity,
                    ]);
                } else {
                    $toTank->productNews()->attach($extra_product_new['product_new_id'], ['quantity' => 0]);
                }

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
            'status' => 'required|string',
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


        // Find the transfer record by its id
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

        // Update the status
        $transferRecord->status = $request->status;
        $transferRecord->save();

        // Update the related product news
//        foreach ($request->actualProductNews as $productNews) {
//            $transferRecord->productNews()->updateExistingPivot($productNews['product_new_id'], [
//                'quantity' => $productNews['quantity'],
//            ]);
//        }

        return response()->json([
            'success' => true,
            'message' => 'Transfer record updated successfully',
        ], 200);
    }



}
