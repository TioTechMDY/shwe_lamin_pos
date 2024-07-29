<?php
//
//namespace App\Models;
//
//use Illuminate\Database\Eloquent\Factories\HasFactory;
//use Illuminate\Database\Eloquent\Model;
//
//class TransferRecord extends Model
//{
//    use HasFactory;
//}


namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class TransferRecord extends Model
{
    use HasFactory;

    protected $fillable = ['from_id', 'to_id', 'from_type', 'to_type'];

    public function productNews()
    {
        return $this->belongsToMany(ProductNew::class, 'transfer_record_product_new', 'transfer_record_id', 'product_new_id')
            ->withPivot('quantity');
    }
}
