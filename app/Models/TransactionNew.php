<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class TransactionNew extends Model
{
    use HasFactory;

    protected $fillable = ['tag'];

    public function shopProductNews()
    {
        return $this->hasManyThrough(ProductNew::class, Shop::class, 'transaction_new_id', 'product_new_id', 'id', 'id');
    }
}
