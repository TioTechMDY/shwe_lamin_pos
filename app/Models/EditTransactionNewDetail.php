<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class EditTransactionNewDetail extends Model
{
    use HasFactory;
    protected $fillable = [
        'product_new_id',
        'old_quantity',
        'new_quantity',
        'edit_transaction_new_id',
    ];
//    public function editTransactionNew()
//    {
//        return $this->belongsTo(EditTransactionNew::class,'edit_transaction_new_id','id');
//    }
// In the EditTransactionNew model

    public function editTransactionNewDetails()
    {
        return $this->hasMany(EditTransactionNewDetail::class);
    }
}
