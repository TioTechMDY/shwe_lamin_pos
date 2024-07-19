<?php

namespace App\Http\Controllers\Api\V1;

use App\CPU\Helpers;
use App\Models\ProductNew;
use App\Models\Shop;
use App\Models\Tank;
use App\Models\TransactionNew;
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
        private TransactionNew $transactionNew,
        private ProductNew $productNew,
        private Tank $tank,
    ){}

    public function createTransferRecord(Request $request)
    {

//        {
//            "sender": "John Doe",
//    "receiver": "Jane Doe",
//    "sender_type": "PO",
//    "receiver_type": "Car",
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


        $transferRecord = TransferRecord::create();

        foreach ($request->product_news as $product_new) {
            $transferRecord->productNews()->attach($product_new['product_new_id'], ['quantity' => $product_new['quantity']]);
        }

        return response()->json($transferRecord->load('productNews'), 201);
    }



}
