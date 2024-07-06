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
        Schema::create('transaction_news', function (Blueprint $table) {
            $table->id();
            $table->string('tag')->default('PO'); // Add a default tag for Purchase Order
            $table->timestamps();
        });
    }

    public function down()
    {
        Schema::dropIfExists('transaction_news');
    }
};
