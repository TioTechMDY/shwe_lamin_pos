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
                return $this->productNews->where('isExtra',0)->map(function ($productNew) {
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


}
