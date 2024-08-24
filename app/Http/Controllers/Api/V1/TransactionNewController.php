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

class TransactionNewController extends Controller
{
    public function __construct(
        private TransactionNew $transactionNew,
        private ProductNew $productNew,
        private Tank $tank,
    ){}
    public function createTransaction(Request $request)
    {

        $productRaw = $request->input('products');
        $products = json_decode($productRaw, true);
        if (!is_array($products)) {
            return response()->json(['error' => $products], 400);
        }

        // Create a new transaction
        $tag = $request->input('tag'); // Get the tag from the request
        $startDate = $request->input('start_date'); // Get the start date from the request
        $endDate = $request->input('end_date'); // Get the end date from the request
        $isPo = $request->input('isPo'); // Get the end date from the request


        $transactionNew = TransactionNew::create(
            [
            'tag' => $tag,
            'start_date' => $startDate,
            'end_date' => $endDate,
            'isPo' => $isPo
            ]
        );

        foreach ($products as $item) {
            $shop = Shop::find($item['shop_id']);
            $productNew = ProductNew::find($item['product_id']);

            if ($shop->product_news()->where('product_new_id', $productNew->id)->exists()) {
                // Retrieve the current quantity
                $currentQuantity = $shop->product_news()->where('product_new_id', $productNew->id)->orderBy('transaction_new_id', 'desc')->first()->pivot->absolute;

                // Increment the quantity by the specified amount
                $newQuantity = $currentQuantity + $item['quantity'];
                $shop->product_news()->updateExistingPivot($productNew->id, [
                    'transaction_id' => 0,
                ]);

                // Update the pivot table
                $shop->product_news()->attach($productNew->id, [
                    'quantity' => $item['quantity'],
                    'absolute' => $newQuantity,
                    'transaction_new_id' => $transactionNew->id,
                    'created_at' => now(),
                    'transaction_id'=>1,
                ]);
            } else {
                // If the product is not attached, attach it with the specified quantity
                $shop->product_news()->attach($productNew->id, [
                    'quantity' => $item['quantity'],
                    'absolute' => $item['quantity'],
                    'transaction_new_id' => $transactionNew->id,
                    'created_at' => now(),
                    'transaction_id'=>1,
                ]);
            }

        }

        return response()->json([
            'success' => true,
            'message' => translate('Expenses saved successfully'),
        ], 200);
    }



}
