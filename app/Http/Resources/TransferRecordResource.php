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
        $toTitle = DB::table('tanks')->where('id', $this->to_id)->value('name');
        if($this->from_type == 1){
            $fromTitle = DB::table('shops')->where('id', $this->from_id)->value('name');
        }else{
            $fromTitle = DB::table('tanks')->where('id', $this->from_id)->value('name');
        }

        return [
            'id' => $this->id,
            'from_id' => $this->from_id,
            'to_id' => $this->to_id,
            'from_type' => $this->from_type,
            'from_title' => $fromTitle,
            'to_type' => $this->to_type,
            'to_title' => $toTitle,
            'isFinal' => $this->isFinal,
            'status' => $this->status,
            'created_at' => $this->created_at,
            'updated_at' => $this->updated_at,
            'extra_description' => $this->extra_description,

            'productDetails' => $this->whenLoaded('productNews', function () {
                return $this->productNews->filter(function ($productNew) {
                    return $productNew->pivot->isExtra == 0;
                })->map(function ($productNew) {
                    return [
                        'id' => $this->id,
                        'product_new_id' => $productNew->id,
                        'product_new_title' => $productNew->name,
                        'quantity' => $productNew->pivot->quantity,
                    ];
                });
            })->values(),
            'extraProductDetails' => $this->whenLoaded('productNews', function () {
                return $this->productNews->filter(function ($productNew) {
                    return $productNew->pivot->isExtra == 1;
                })->map(function ($productNew) {
                    return [
                        'id' => $this->id,
                        'product_new_id' => $productNew->id,
                        'product_new_title' => $productNew->name,
                        'quantity' => $productNew->pivot->quantity,
                    ];
                });
            })->values(),
            'actualProductDetails' => $this->whenLoaded('productNews', function () {
                return $this->productNews->filter(function ($productNew) {
                    return $productNew->pivot->isExtra == 2;
                })->map(function ($productNew) {
                    return [
                        'id' => $this->id,
                        'product_new_id' => $productNew->id,
                        'product_new_title' => $productNew->name,
                        'quantity' => $productNew->pivot->quantity,
                    ];
                });
            })->values(),
        ];
    }


}
