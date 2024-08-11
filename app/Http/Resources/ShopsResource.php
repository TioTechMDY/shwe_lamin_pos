<?php

namespace App\Http\Resources;
use Illuminate\Http\Resources\Json\JsonResource;

class ShopsResource extends JsonResource
{
    /**
     * Transform the resource into an array.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return array|\Illuminate\Contracts\Support\Arrayable|\JsonSerializable
     */
    public function toArray($request)
    {
        //return parent::toArray($request);
        $productNews = $this->productNews()
            ->wherePivot('transaction_id', 1)
            ->get()
            ->map(function ($product) {
                return [
                    'id' => $product->id,
                    'title' => $product->name,
                    'image' => $product->image,
                    'quantity' => $product->pivot->absolute,
                ];
            });
        return [
            'id' => $this->id,
            'title' => $this->name,
            'phonenumber' => $this->phonenumber,
            'description'=>$this->description,
            'image' => $this->image,
            'productnews' => $productNews,
        ];
    }
}
