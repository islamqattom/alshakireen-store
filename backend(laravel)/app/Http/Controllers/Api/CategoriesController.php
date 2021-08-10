<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\Category;
use Illuminate\Http\Request;
use App\Http\Helpers\ResponseBuilder;
use Illuminate\Support\Str;
use Illuminate\Support\Facades\Storage;

class CategoriesController extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index()
    {
        return ResponseBuilder::resultWithData(true,'successfully',Category::all());
    }

    /**
     * Show the form for creating a new resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function create()
    {
        //
    }

    /**
     * Store a newly created resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return \Illuminate\Http\Response
     */
    public function store(Request $request)
    {
        $request->validate([
            'name'=>'required',
            'image'=>'required', 
            'icon'=>'required', 
        ]);

        $newCat= new Category();
        $newCat->name=$request->get('name');
        $image=$request->get('image');
        $icon=$request->get('icon');

        $safeName = Str::random(10).'.png';
        Storage::put('public/images/categories/' . $safeName, base64_decode($image));
        
        $safeIconName = Str::random(10).'.png';
        Storage::put('public/images/categories/' . $safeIconName, base64_decode($icon));
        
        $newCat->image=$safeName;
        $newCat->icon=$safeIconName;

       return ResponseBuilder::result($newCat->save()?true:false,'added successfully');
    }

    /**
     * Display the specified resource.
     *
     * @param  \App\Models\Category  $category
     * @return \Illuminate\Http\Response
     */
    public function show($id)
    {
        //
    }

    /**
     * Show the form for editing the specified resource.
     *
     * @param  \App\Models\Category  $category
     * @return \Illuminate\Http\Response
     */
    public function edit(Category $category)
    {
        //
    }

    /**
     * Update the specified resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  \App\Models\Category  $category
     * @return \Illuminate\Http\Response
     */
    public function update(Request $request, Category $category)
    {
        //
    }

    /**
     * Remove the specified resource from storage.
     *
     * @param  \App\Models\Category  $category
     * @return \Illuminate\Http\Response
     */
    public function destroy($id)
    {
        $destroy=Category::destroy($id);
        return ResponseBuilder::result((bool)$destroy,'successfully');
    }
}
