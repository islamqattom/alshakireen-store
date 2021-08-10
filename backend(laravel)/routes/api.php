<?php

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;

/*
|--------------------------------------------------------------------------
| API Routes
|--------------------------------------------------------------------------
|
| Here is where you can register API routes for your application. These
| routes are loaded by the RouteServiceProvider within a group which
| is assigned the "api" middleware group. Enjoy building your API!
|
*/

Route::middleware('auth:api')->get('/user', function (Request $request) {
    return $request->user();
});

//user management
Route::post('addUser','App\Http\Controllers\Api\UsersController@store');
Route::post('login','App\Http\Controllers\Api\UsersController@show');
Route::get('getUsers','App\Http\Controllers\Api\UsersController@index');
Route::post('deleteUser/{userid}','App\Http\Controllers\Api\UsersController@destroy');



//category api's
Route::post('addCategory','App\Http\Controllers\Api\CategoriesController@store');
Route::get('getCategories','App\Http\Controllers\Api\CategoriesController@index');
Route::post('deleteCategory/{userid}','App\Http\Controllers\Api\CategoriesController@destroy');


//sub category api's
Route::post('addSubCategory','App\Http\Controllers\Api\SubCategoriesController@store');
Route::get('getSubCategories','App\Http\Controllers\Api\SubCategoriesController@index');
Route::get('getSubCategories/{id}','App\Http\Controllers\Api\SubCategoriesController@show');
Route::post('deleteSubCategory/{userid}','App\Http\Controllers\Api\SubCategoriesController@destroy');


//item api's
Route::post('addItem','App\Http\Controllers\Api\ItemsController@store');
Route::get('getItems','App\Http\Controllers\Api\ItemsController@index');
Route::get('getSpesificItems/{id}','App\Http\Controllers\Api\ItemsController@show');
Route::get('showOneItem/{id}/{userId}','App\Http\Controllers\Api\ItemsController@showOneItem');
Route::post('deleteItem/{userid}','App\Http\Controllers\Api\ItemsController@destroy');


//cart api's
Route::post('addCart','App\Http\Controllers\Api\CartsController@store');
Route::get('getCarts','App\Http\Controllers\Api\CartsController@index');
Route::get('getCarts/{id}','App\Http\Controllers\Api\CartsController@show'); //user id
Route::get('getSold','App\Http\Controllers\Api\CartsController@soldItems'); 
Route::get('getUserItems/{userId}','App\Http\Controllers\Api\CartsController@userItems');
Route::get('getUser/{userid}','App\Http\Controllers\Api\CartsController@ItemUsers');
Route::post('deleteCart/{userid}','App\Http\Controllers\Api\CartsController@destroy');


//comment api's
Route::post('addComment','App\Http\Controllers\Api\CommentsController@store');
Route::get('getComments','App\Http\Controllers\Api\CommentsController@index');
Route::get('getComment/{userid}','App\Http\Controllers\Api\CommentsController@show');
Route::post('deleteComment/{userid}','App\Http\Controllers\Api\CommentsController@destroy');


//favorate api's
Route::post('addFavorate','App\Http\Controllers\Api\FavoratesController@store');
Route::get('getFavorates/{userId}','App\Http\Controllers\Api\FavoratesController@show');

//Slider api's
Route::post('addSlider','App\Http\Controllers\Api\SliderController@store');
Route::get('getSlider','App\Http\Controllers\Api\SliderController@index');

Route::get('image', function (){
   echo Storage::get('/images/categories/bMCF9RLK5L.png');
});