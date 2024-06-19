<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Tank extends Model
{
    use HasFactory;

    protected $fillable = [
        'name',
        'description',
        'image',
        'quantity',
        'created_at',
        'updated_at',
        'product_id',
    ];

    public function product()
    {
        return $this->belongsTo(Product::class,'product_id');
    }
}
