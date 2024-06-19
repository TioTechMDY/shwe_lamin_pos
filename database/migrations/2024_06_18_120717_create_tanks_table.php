php
<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateTanksTable extends Migration
{
    public function up()
    {
        Schema::create('tanks', function (Blueprint $table) {
            $table->id();
            $table->string('name');
            $table->text('description');
            $table->string('image');
            $table->integer('quantity');
            $table->timestamps();
            $table->bigInteger('product_id')->nullable();
        });
    }

    public function down()
    {
        Schema::dropIfExists('tanks');
    }
}
