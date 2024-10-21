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
        Schema::table('transfer_records', function (Blueprint $table) {
            $table->integer('created_by');
            $table->integer('confirmed_by')->nullable();
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::table('transfer_records', function (Blueprint $table) {
            $table->dropColumn('created_by');
            $table->dropColumn('confirmed_by');

        });
    }
};
