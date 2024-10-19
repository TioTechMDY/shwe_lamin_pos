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
    ];
}
