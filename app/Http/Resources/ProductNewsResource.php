<?php

namespace App\Http\Resources;
use App\Models\Brand;
use App\Models\Supplier;
use Illuminate\Http\Resources\Json\JsonResource;

class ProductNewsResource extends JsonResource
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
        return [
            'id' => $this->id,
            'title' => $this->name,
            'quantity' => $this->quantity,
            'image' => $this->image,
          ];
    }
}
