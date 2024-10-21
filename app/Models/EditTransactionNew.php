<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class EditTransactionNew extends Model
{
    use HasFactory;

    protected $fillable = [
        'shop_id',
        'product_new_id',
        'old_quantity',
        'new_quantity',
        'transaction_new_id',
        'admin_id',
    ];

    public function productNew()
    {
        return $this->belongsTo(ProductNew::class, 'product_new_id');
    }
    public  function  shop()
    {
        return $this->belongsTo(Shop::class, 'shop_id');

    }
    public  function  admin()
    {
        return $this->belongsTo(Admin::class, 'admin_id');
    }
}
