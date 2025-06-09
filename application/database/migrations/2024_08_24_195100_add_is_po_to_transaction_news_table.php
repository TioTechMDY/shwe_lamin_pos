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
        Schema::table('transaction_news', function (Blueprint $table) {
            $table->string('isPo')->default('');
            $table->string('start_date')->nullable();
            $table->string('end_date')->nullable();
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::table('transaction_news', function (Blueprint $table) {
            $table->dropColumn('isPo');
            $table->dropColumn('start_date');
            $table->dropColumn('end_date');
        });
    }
};
//make:migration add_extra_description_to_transfer_records_table --table=transfer_records

