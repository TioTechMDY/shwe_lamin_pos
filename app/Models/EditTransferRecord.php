<?php

// app/Models/EditTransferRecord.php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class EditTransferRecord extends Model
{
    use HasFactory;

    protected $fillable = [
        'transfer_record_id',
        'product_new_id',
        'old_quantity',
        'new_quantity',
        'admin_id',
    ];

    public function transferRecord()
    {
        return $this->belongsTo(TransferRecord::class, 'transfer_record_id');
    }

    public function productNew()
    {
        return $this->belongsTo(ProductNew::class, 'product_new_id');
    }
    public function  admin()
    {
        return $this->belongsTo(Admin::class, 'admin_id');
    }
}
