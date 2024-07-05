<?php

namespace App\Http\Resources;
use Illuminate\Http\Resources\Json\JsonResource;

class TanksResource extends JsonResource
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
            'name' => $this->name,
            'total_quantity' => $this->total_quantity,
            'description'=>$this->description,
            'image' => $this->image,
            'is_car' => $this->is_car,
          ];
    }
}
