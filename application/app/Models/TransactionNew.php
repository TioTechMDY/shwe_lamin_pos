<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class TransactionNew extends Model
{
    use HasFactory;

    protected $fillable = ['tag', 'start_date', 'end_date', 'isPo','created_by'];
    public function shopProductNews()
    {
        return $this->hasManyThrough(ProductNew::class, Shop::class, 'transaction_new_id', 'product_new_id', 'id', 'id');
    }


    public function productNews()
    {
        return $this->belongsToMany(ProductNew::class, 'product_new_shop', 'transaction_new_id', 'product_new_id')
            ->withPivot('quantity', 'absolute');
    }

    public function shops()
    {
        return $this->belongsToMany(Shop::class, 'product_new_shop', 'transaction_new_id', 'shop_id')
            ->withPivot('quantity', 'absolute');
    }

    public  function createdBy()
    {
        return $this->belongsTo(Admin::class, 'created_by', 'id');
    }


}
