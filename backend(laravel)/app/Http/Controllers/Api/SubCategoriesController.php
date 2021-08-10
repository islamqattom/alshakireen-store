<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\SubCategory;
use Illuminate\Http\Request;
use App\Http\Helpers\ResponseBuilder;
use Illuminate\Support\Str;
use Illuminate\Support\Facades\Storage;

class SubCategoriesController extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index()
    {
        return ResponseBuilder::resultWithData(true,'successfuly',SubCategory::all());
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
            'category_id'=>'required',
            'image'=>'required'
        ]);

        $newCat=new SubCategory();
        $newCat->name=$request->get('name');
        $newCat->category_id=$request->get('category_id');
        $image=$request->get('image');

        $safeName = Str::random(10).'.jpg';
        Storage::put('public/images/subCategories/' . $safeName, base64_decode($image));

        $newCat->image=$safeName;

        return ResponseBuilder::result($newCat->save()?true:false,'added successfully');

    }

    /**
     * Display the specified resource.
     *
     * @param  \App\Models\SubCategory  $subCategory
     * @return \Illuminate\Http\Response
     */
    public function show($id)
    {
        try{
        $subCats=SubCategory::where('category_id',$id)->get();
            return ResponseBuilder::resultWithData(true, 'successfully',$subCats);
        }catch(Exception $e){
            return ResponseBuilder::resultWithData(false, 'not success',null);
        }
    }

    /**
     * Show the form for editing the specified resource.
     *
     * @param  \App\Models\SubCategory  $subCategory
     * @return \Illuminate\Http\Response
     */
    public function edit(SubCategory $subCategory)
    {
        //
    }

    /**
     * Update the specified resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  \App\Models\SubCategory  $subCategory
     * @return \Illuminate\Http\Response
     */
    public function update(Request $request, SubCategory $subCategory)
    {
        //
    }

    /**
     * Remove the specified resource from storage.
     *
     * @param  \App\Models\SubCategory  $subCategory
     * @return \Illuminate\Http\Response
     */
    public function destroy($id)
    {
        $destroy=SubCategory::destroy($id);
        return ResponseBuilder::result((bool)$destroy,'successfully');
    }
}
