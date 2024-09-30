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
        $shopQuantity = DB::table('product_new_shop')->where('product_new_id', $this->id)->where('transaction_id',1)->sum('absolute');
        // I want to filter tank or car quantity. The value of tank or car is is_car in tank table, The tank id is a foreign key in product_new_tank table


        $tankQuantity = DB::table('product_new_tank')
            ->join('tanks', 'product_new_tank.tank_id', '=', 'tanks.id')
            ->where('product_new_tank.product_new_id', $this->id)
            ->where('tanks.is_car', 0)
            ->sum('product_new_tank.quantity');

        $carQuantity = DB::table('product_new_tank')
            ->join('tanks', 'product_new_tank.tank_id', '=', 'tanks.id')
            ->where('product_new_tank.product_new_id', $this->id)
            ->where('tanks.is_car', 1)
            ->sum('product_new_tank.quantity');

        $totalQuantity = DB::table('product_new_shop')->where('product_new_id', $this->id)->where('transaction_id',1)->sum('absolute')
            + DB::table('product_new_tank')->where('product_new_id', $this->id)->sum('quantity');
        return [
            'id' => $this->id,
            'title' => $this->name,
//            'quantity' => $this->quantity,
            'quantity' => $totalQuantity,
            'shop_quantity'=>$shopQuantity,
            'car_quantity'=>$carQuantity,
            'tank_quantity'=>$tankQuantity,
            'image' => $this->image,
        ];
    }
}
