<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class EditTransactionNew extends Model
{
    use HasFactory;

    protected $fillable = [
        'transaction_new_id',
        'admin_id',
    ];

    public function transactionNew()
    {
        return $this->belongsTo(TransactionNew::class, 'transaction_new_id','id');
    }

    public  function  admin()
    {
        return $this->belongsTo(Admin::class, 'admin_id','id');
    }
}
