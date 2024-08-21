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
        Schema::create('tanks', function (Blueprint $table) {
            $table->id();
            $table->string('name');
            $table->integer('total_quantity')->nullable();
            $table->string('image')->nullable();
            $table->string('description')->nullable();
            $table->boolean('is_car');
            $table->string('car_series')->nullable();
            $table->string('car_type')->nullable();
            $table->string('driver_name')->nullable();
            $table->string('driver_phone_number')->nullable();
            $table->boolean('is_paid')->nullable();
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
        Schema::dropIfExists('tanks');
    }
};
