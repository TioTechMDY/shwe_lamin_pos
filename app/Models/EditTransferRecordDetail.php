<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class EditTransferRecordDetail extends Model
{
    use HasFactory;
    protected $fillable = [
        'product_new_id',
        'old_quantity',
        'new_quantity',
        'edit_transfer_record_id',
    ];
    public function editTransferRecord()
    {
        return $this->belongsTo(EditTransferRecord::class,'edit_transfer_record_id','id');
    }
}
