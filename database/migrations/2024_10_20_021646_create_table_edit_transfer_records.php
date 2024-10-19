<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('edit_transfer_records', function (Blueprint $table) {
            $table->id();
            $table->foreignId('transfer_record_id')->constrained('transfer_records');
            $table->foreignId('product_new_id')->constrained('product_news');
            $table->integer('old_quantity');
            $table->integer('new_quantity');
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('edit_transfer_records');
    }
};
