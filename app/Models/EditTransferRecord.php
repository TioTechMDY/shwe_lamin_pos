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
        'admin_id',
    ];

    public function transferRecord()
    {
        return $this->belongsTo(TransferRecord::class, 'transfer_record_id', 'id');
    }

    public function  admin()
    {
        return $this->belongsTo(Admin::class, 'admin_id','id');
    }
    public function editTransferRecordDetails()
    {
        return $this->hasMany(EditTransferRecordDetail::class, 'edit_transaction_new_id', 'id');
    }
}
