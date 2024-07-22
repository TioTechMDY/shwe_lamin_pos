<?php

namespace App\Http\Resources;
use Illuminate\Http\Resources\Json\JsonResource;
use Illuminate\Support\Facades\DB;

class TransferRecordResource extends JsonResource
{
    /**
     * Transform the resource into an array.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return array|\Illuminate\Contracts\Support\Arrayable|\JsonSerializable
     */

    public function toArray($request)
    {
        return [
            'id' => $this->id,
            'from_id' => $this->from_id,
            'to_id' => $this->to_id,
            'from_type' => $this->from_type,
            'to_type' => $this->to_type,
            'productDetails' => $this->whenLoaded('productNews', function () {
                return $this->productNews->map(function ($productNew) {
                    $shop = DB::table('transfer_record_product_new')
                        ->join('product_news', 'transfer_record_product_new.product_new_id', '=', 'product_news.id')
                        ->where('transfer_record_product_new.transfer_record_id', $this->id)
                        ->where('transfer_record_product_new.product_new_id', $productNew->id)
                        ->select('product_news.id as product_new_id', 'product_news.name as product_new_title')
                        ->first();

                    return [
                        'id' => $this->id,
                        'product_new_id' => $productNew->id,
                        'product_new_title' => $productNew->name,
                        'quantity' => $productNew->pivot->quantity,
                    ];
                });
            }),
        ];
    }

//    public function toArray($request)
//    {
//        return [
//            'id' => $this->id,
//            'from_id' => $this->from_id,
//            'to_id' => $this->to_id,
//            'from_type' => $this->from_type,
//            'to_type' => $this->to_type,
//            'productDetails' => $this->whenLoaded('productNews', function () {
//                return $this->productNews->map(function ($productNew) {
//                    $shop = DB::table('product_new_shop')
//                        ->join('shops', 'product_new_shop.shop_id', '=', 'shops.id')
//                        ->where('product_new_shop.transaction_new_id', $this->id)
//                        ->where('product_new_shop.product_new_id', $productNew->id)
//                        ->select('shops.id as shop_id', 'shops.name as shop_title')
//                        ->first();
//
//                    return [
//                        'id' => $this->id,
//                        'product_new_id' => $productNew->id,
//                        'product_new_title' => $productNew->name,
//                        'quantity' => $productNew->pivot->quantity,
//                    ];
//                });
//            }),
//        ];
//    }

}
