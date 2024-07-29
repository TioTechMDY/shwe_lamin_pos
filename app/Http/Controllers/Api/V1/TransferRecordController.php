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
        $fromId = $request->input('from_id'); // Get the tag from the request
        $fromType = $request->input('from_type');

        $toId = $request->input('to_id'); // Get the tag from the request
        $toType = $request->input('to_type');


        $transferRecord = TransferRecord::create(
            [
//                'from_id' => $fromId,
//                'from_type'=>$fromType,
//                'to_id'=>$toId,
//                'to_type'=>$toType

                'from_id' => 1,
                'from_type'=>1,
                'to_id'=>1,
                'to_type'=>2
            ]
        );

        foreach ($products as $product_new) {
            $transferRecord->productNews()->attach($product_new['product_new_id'], ['quantity' => $product_new['quantity']]);
        }

//        return response()->json($transferRecord->load('productNews'), 201);
        return response()->json([
            'success' => true,
            'message' => translate('Transfer Record saved successfully'),
        ], 200);
    }



}
