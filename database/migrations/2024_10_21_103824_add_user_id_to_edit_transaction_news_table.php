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
        Schema::table('edit_transaction_news', function (Blueprint $table) {
            $table->foreignId('admin_id')->constrained('admins')->after('new_quantity');
        });
    }

    public function down()
    {
        Schema::table('edit_transaction_news', function (Blueprint $table) {
            $table->dropForeign(['admin_id']);
            $table->dropColumn('admin_id');
        });
    }
};
