<?php

namespace App\Http\Resources;
use Illuminate\Http\Resources\Json\JsonResource;

class TransactionNewsResource extends JsonResource
{
    /**
     * Transform the resource into an array.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return array|\Illuminate\Contracts\Support\Arrayable|\JsonSerializable
     */
//    public function toArray($request)
//    {
//        return [
//            'id' => $this->id,
//            'name' => $this->tag,
//            'details' => $this->whenLoaded('productNews', function () {
//                return $this->productNews->map(function ($productNew) {
//                    return [
//                        'id' => $productNew->id,
//                        'quantity' => $productNew->pivot, // this will include the pivot data
//                    ];
//                });
//            }),
//        ];
//    }
    public function toArray($request)
    {
        return [
            'id' => $this->id,
            'name' => $this->tag,
            'details' => $this->whenLoaded('productNews', function () {
                return $this->productNews->map(function ($productNew) {
                    return [
                        'id' => $productNew->pivot->id,
                        'product_new_id' => $productNew->id,
                        'product_new_title' => $productNew->name,
                        'shop_id' => $productNew->pivot->shop_id,
                        'shop_title' => $this->shops->firstWhere('id', $productNew->pivot->shop_id)->name,
                        'quantity' => $productNew->pivot->quantity,
                        'absolute' => $productNew->pivot->absolute,
                    ];
                });
            }),
        ];
    }
}
