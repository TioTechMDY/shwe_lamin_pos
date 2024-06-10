<?php

use Illuminate\Support\Facades\Route;
use Illuminate\Support\Facades\Storage;
/*
|--------------------------------------------------------------------------
| Web Routes
|--------------------------------------------------------------------------
|
| Here is where you can register web routes for your application. These
| routes are loaded by the RouteServiceProvider within a group which
| contains the "web" middleware group. Now create something great!
|
*/


Route::get('storage/app/public/admin/{file}', function ($file) {
    // Get the full path to the file
    $filePath = storage_path('app/public/admin/' . $file);

    // Check if the file exists
    if (file_exists($filePath)) {
        // Return the file with appropriate headers
        return response()->file($filePath);
    } else {
        // Return a 404 Not Found response if the file doesn't exist
        return response()->json(['error' => 'File not found'], 404);
    }
});
Route::get('storage/app/public/brand/{file}', function ($file) {
    // Get the full path to the file
    $filePath = storage_path('app/public/brand/' . $file);

    // Check if the file exists
    if (file_exists($filePath)) {
        // Return the file with appropriate headers
        return response()->file($filePath);
    } else {
        // Return a 404 Not Found response if the file doesn't exist
        return response()->json(['error' => 'File not found'], 404);
    }
});
Route::get('storage/app/public/category/{file}', function ($file) {
    // Get the full path to the file
    $filePath = storage_path('app/public/category/' . $file);

    // Check if the file exists
    if (file_exists($filePath)) {
        // Return the file with appropriate headers
        return response()->file($filePath);
    } else {
        // Return a 404 Not Found response if the file doesn't exist
        return response()->json(['error' => 'File not found'], 404);
    }
});
Route::get('storage/app/public/customer/{file}', function ($file) {
    // Get the full path to the file
    $filePath = storage_path('app/public/customer/' . $file);

    // Check if the file exists
    if (file_exists($filePath)) {
        // Return the file with appropriate headers
        return response()->file($filePath);
    } else {
        // Return a 404 Not Found response if the file doesn't exist
        return response()->json(['error' => 'File not found'], 404);
    }
});
Route::get('storage/app/public/product/{file}', function ($file) {
    // Get the full path to the file
    $filePath = storage_path('app/public/product/' . $file);

    // Check if the file exists
    if (file_exists($filePath)) {
        // Return the file with appropriate headers
        return response()->file($filePath);
    } else {
        // Return a 404 Not Found response if the file doesn't exist
        return response()->json(['error' => 'File not found'], 404);
    }
});
Route::get('storage/app/public/shop/{file}', function ($file) {
    // Get the full path to the file
    $filePath = storage_path('app/public/shop/' . $file);

    // Check if the file exists
    if (file_exists($filePath)) {
        // Return the file with appropriate headers
        return response()->file($filePath);
    } else {
        // Return a 404 Not Found response if the file doesn't exist
        return response()->json(['error' => 'File not found'], 404);
    }
});
Route::get('storage/app/public/supplier/{file}', function ($file) {
    // Get the full path to the file
    $filePath = storage_path('app/public/supplier/' . $file);

    // Check if the file exists
    if (file_exists($filePath)) {
        // Return the file with appropriate headers
        return response()->file($filePath);
    } else {
        // Return a 404 Not Found response if the file doesn't exist
        return response()->json(['error' => 'File not found'], 404);
    }
});


Route::fallback(function(){
    return redirect('admin/auth/login');
});

Route::get('authentication-failed', function () {
    $errors = [];
    array_push($errors, ['code' => 'auth-001', 'message' => 'Invalid credential! or unauthenticated.']);
    return response()->json([
        'errors' => $errors
    ], 401);
})->name('authentication-failed');
