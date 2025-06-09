<?php

namespace App\Http\Resources;
use Illuminate\Http\Resources\Json\JsonResource;
use Illuminate\Support\Facades\DB;

class TransactionNewsResource extends JsonResource
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
            'name' => $this->tag,
            'created_at' => $this->created_at,
            'updated_at' => $this->updated_at,
            'start_date' => $this->start_date,
            'end_date' => $this->end_date,
            'isPo' => $this->isPo,
            'created_by_id'=> $this->created_by,
            'created_by' => $this->createdBy->f_name . ' ' . $this->createdBy->l_name,
            'details' => $this->whenLoaded('productNews', function () {
                return $this->productNews->map(function ($productNew) {
                    $shop = DB::table('product_new_shop')
                        ->join('shops', 'product_new_shop.shop_id', '=', 'shops.id')
                        ->where('product_new_shop.transaction_new_id', $this->id)
                        ->where('product_new_shop.product_new_id', $productNew->id)
                        ->select('shops.id as shop_id', 'shops.name as shop_title')
                        ->first();

                    return [
                        'id' => $this->id,
                        'product_new_id' => $productNew->id,
                        'product_new_title' => $productNew->name,
                        'shop_id' => $shop->shop_id,
                        'shop_title' => $shop->shop_title,
                        'quantity' => $productNew->pivot->quantity,
                        'absolute' => $productNew->pivot->absolute,
                    ];
                });
            }),
        ];
    }

}
