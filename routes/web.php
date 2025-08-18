<?php

use Illuminate\Support\Facades\Route;

// เปลี่ยนหน้าแรกให้ redirect ไปยังหน้า login
Route::get('/', function () {
    return redirect('/login');
});

// (ถ้าอยากให้ยังสามารถเข้าหน้า about ได้)
Route::get('/about', function () {
    return view('about');
});

// กลุ่ม route ที่ต้อง login แล้วเท่านั้นจึงเข้าถึงได้
Route::middleware([
    'auth:sanctum',
    config('jetstream.auth_session'),
    'verified',
])->group(function () {
    Route::get('/dashboard', function () {
        return view('dashboard');
    })->name('dashboard');
});
