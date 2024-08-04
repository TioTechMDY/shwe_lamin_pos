<?php

namespace App\Http\Resources;
use App\Models\Brand;
use App\Models\Supplier;
use Illuminate\Http\Resources\Json\JsonResource;
use Illuminate\Support\Facades\DB; // Add this line


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
        $totalQuantity = DB::table('product_new_shop')->where('product_new_id', $this->id)->where('transaction_id',1)->sum('absolute')
            + DB::table('product_new_tank')->where('product_new_id', $this->id)->sum('quantity');
        return [
            'id' => $this->id,
            'title' => $this->name,
//            'quantity' => $this->quantity,
            'quantity' => $totalQuantity,
            'image' => $this->image,
          ];
    }
}
