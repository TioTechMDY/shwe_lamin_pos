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

    public function editTransaction(Request $request)
    {
        // Get the transaction id from the request
        $transactionId = $request->input('id');

        // Find the transaction in the database
        $transaction = TransactionNew::find($transactionId);

        // If the transaction does not exist, return an error response
        if (!$transaction) {
            return response()->json(['error' => 'Transaction not found'], 404);
        }

        // Get the products from the request
        $products = $request->input('products');

        // Loop through each product
        foreach ($products as $item) {
            // Find the shop and product in the database
            $shop = Shop::find($item['shop_id']);
            $productNew = ProductNew::find($item['product_id']);

            // If the shop or product does not exist, continue to the next item
            if (!$shop || !$productNew) {
                continue;
            }

            // product and shop are already attached. want  to update the quantity of the product in the shop
                if ($shop->product_news()->where('product_new_id', $productNew->id)->exists()) {
                // Retrieve the current quantity
                $currentQuantity = $shop->product_news()->where('product_new_id', $productNew->id)->orderBy('transaction_new_id', 'desc')->first()->pivot->absolute;

                // Increment the quantity by the specified amount
                $newQuantity = $currentQuantity + $item['new_quantity']-$item['old_quantity'];
                $shop->product_news()->updateExistingPivot($productNew->id, [
                    'quantity' => $item['new_quantity'],
                    'absolute' => $newQuantity,
                    'transaction_new_id' => $transaction->id,
                    'created_at' => now(),
                    'transaction_id'=>1,


                ]);

                // Update the pivot table
//                $shop->product_news()->attach($productNew->id, [
//                    'quantity' => $item['quantity'],
//                    'absolute' => $newQuantity,
//                    'transaction_new_id' => $transaction->id,
//                    'created_at' => now(),
//                    'transaction_id'=>1,
//                ]);
            } else {
                // If the product is not attached, attach it with the specified quantity
                $shop->product_news()->attach($productNew->id, [
                    'quantity' => $item['quantity'],
                    'absolute' => $item['quantity'],
                    'transaction_new_id' => $transaction->id,
                    'created_at' => now(),
                    'transaction_id'=>1,
                ]);
            }




            // If the product is attached to the shop, update the quantity
//            if ($shop->product_news()->where('product_new_id', $productNew->id)->exists()) {
//                $currentQuantity = $shop->product_news()->where('product_new_id', $productNew->id)->orderBy('transaction_new_id', 'desc')->first()->pivot->absolute;
//
//                // Calculate the new absolute quantity
//                $newQuantity = $item['new_quantity'];
//                $oldQuantity = $item['old_quantity'];
//                $absolute = $currentQuantity + $newQuantity - $oldQuantity;
//
//                // Update the pivot table
//                $shop->product_news()->updateExistingPivot($productNew->id, [
//                    'quantity' => $item['new_quantity'],
//                    'absolute' => $absolute,
//                    'transaction_new_id' => $transaction->id,
//                ]);
//            }
        }

        // Update the transaction's start and end dates
        $transaction->start_date = $request->input('start_date');
        $transaction->end_date = $request->input('end_date');
        $transaction->save();

        return response()->json([
            'success' => true,
            'message' => 'Transaction updated successfully',
        ], 200);
    }

   public function editTransaction1(Request $request){
        $transactionId = $request->input('transaction_id');
        $productRaw = $request->input('products');
        $products = json_decode($productRaw, true);
        if (!is_array($products)) {
            return response()->json(['error' => $products], 400);
        }

        $transactionNew = TransactionNew::find($transactionId);
        if (!$transactionNew) {
            return response()->json(['error' => translate('Transaction not found')], 404);
        }

        foreach ($products as $item) {
            $shop = Shop::find($item['shop_id']);
            $productNew = ProductNew::find($item['product_id']);

            if ($shop->product_news()->where('product_new_id', $productNew->id)->exists()) {
                // Retrieve the current quantity
                $currentQuantity = $shop->product_news()->where('product_new_id', $productNew->id)->orderBy('transaction_new_id', 'desc')->first()->pivot->absolute;

                // Increment the quantity by the specified amount
                $newQuantity = $currentQuantity + $item['new_quantity']-$item['old_quantity'];
//                $shop->product_news()->updateExistingPivot($productNew->id, [
//                    'transaction_id' => 0,
//                ]);

                // Update the pivot table
                $shop->product_news()->updateExistingPivot($productNew->id, [
                    'quantity' => $item['new_quantity'],
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
