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

//        {
//            "from_id": 2,
//    "to_id": 1,
//    "from_type": 1,
//    "to_type": 2,
//    "product_news": [
//        {
//            "product_new_id": 1,
//            "quantity": 10
//        },
//        {
//            "product_new_id": 2,
//            "quantity": 5
//        }
//    ]
//}
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
                'to_type'=>$toType
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

            if ($toTank->product_news()->where('product_new_id', $product_new['product_new_id'])->exists()) {
                $recieverCurrentQuantity = $toTank->productNews()->where('product_new_id', $product_new['product_new_id'])->first()->pivot->quantity;

                $newRecieverQuantity = $recieverCurrentQuantity + $product_new['quantity'];

                $toTank->productNews()->updateExistingPivot($product_new['product_new_id'], [
                    'quantity' => $newRecieverQuantity,
                ]);
            } else {
                $toTank->productNews()->attach($product_new['product_new_id'], ['quantity' => $product_new['quantity']]);
            }
            if($from == 'shop'){
//                $senderCurrentQuantity = $fromShop->productNews()->where('product_new_id', $product_new['product_new_id'])->first()->pivot->quantity;
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

            if ($toTank->product_news()->where('product_new_id', $extra_product_new['product_new_id'])->exists()) {
                $recieverCurrentQuantity = $toTank->productNews()->where('product_new_id', $extra_product_new['product_new_id'])->first()->pivot->quantity;

                $newRecieverQuantity = $recieverCurrentQuantity + $extra_product_new['quantity'];

                $toTank->productNews()->updateExistingPivot($extra_product_new['product_new_id'], [
                    'quantity' => $newRecieverQuantity,
                ]);
            } else {
                $toTank->productNews()->attach($extra_product_new['product_new_id'], ['quantity' => $extra_product_new['quantity']]);
            }

        }


        return response()->json([
            'success' => true,
            'message' => translate('Transfer Record saved successfully'),
        ], 200);
    }



}
