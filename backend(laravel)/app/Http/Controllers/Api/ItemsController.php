<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\Slider;
use App\Models\item;
use App\Models\Category;
use App\Models\Favorate;
use App\Models\SubCategory;
use App\Models\Images;
use Illuminate\Http\Request;
use App\Http\Helpers\ResponseBuilder;
use Illuminate\Support\Str;
use Illuminate\Support\Facades\Storage;
class ItemsController extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index()
    {
        try{
            $categories=Category::all();
            foreach ($categories as $category) {
                $subCategories=SubCategory::where('category_id',$category->id)->get();
                
                $allItems=[];
                $newAllItems=[];
                $count=0;
                foreach ($subCategories as $key => $subCategory) {
                    $items=Item::where('subcategory_id',$subCategory->id)->inRandomOrder()->get();
                    $allItems[$key]=$items;
                }
                foreach ($allItems as $key => $value) {
                   foreach($value as $k => $v){
                       $newAllItems[$count]=$v;

                       $count++;
                   }
                }
                shuffle($newAllItems);
                $category['items'] = array_slice($newAllItems, 0, 100);
                foreach ($category['items'] as $item) {
                    $groups=Images::where('item_id',$item->id)->get();
                    $item['colors']=count($groups);
                                     
                    if(count($groups)>0){
                        $item['color']=$groups[0]['color']; 
                        $item['image']=explode(',', $groups[0]['images'])[0];
                    }
                    else{
                            $item['color']=null; 
                            $item['image']=null;
                    }
                }
            }
            return ResponseBuilder::resultWithData(true,"successfuly", $categories);

        }catch(Exception $e){
            return ResponseBuilder::resultWithData(false,"not successfuly",null);
        }
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
            'images'=>'required',
            'subcategory_id'=>'required',
            'description'=>'required',
            'status'=>'required',
            'price'=>'required',
        ]);

       try{
        $newItem= new Item();
        $newItem->name=$request->get('name');
        $newItem->subcategory_id=$request->get('subcategory_id');
        $newItem->description=$request->get('description');
        $newItem->status=$request->get('status');
        $newItem->price=$request->get('price');
        
        $newItem->save();

        $itemImages ='' ;
        $images = $request->get('images');
        foreach($images as $image){
            $newImage=new Images();
            $newImage->item_id= $newItem->id;
            $newImage->color=$image['color'];

            $itemImages='';
            foreach($image['image'] as $obj){
                $safeName = Str::random(10).'.png';
                Storage::put('public/images/items/' . $safeName, base64_decode($obj));
                $itemImages .= $safeName . ',';
            }
            $newImage->images=$itemImages;
            $newImage->save();
        }

        return ResponseBuilder::result(true,'added successfully');
       }catch(Exception $e){
        return ResponseBuilder::result(false,'error occurred');
       }
    }
    
    
    /**
     * Display the specified resource.
     *
     * @param  \App\Models\item  $item
     * @return \Illuminate\Http\Response
     */
    public function show($id)
    {
       $items=Item::where('subcategory_id',$id)->inRandomOrder()->get();
       foreach ($items as $value) {
            $groups=Images::where('item_id',$value->id)->get();
            $value['colors']=count($groups);
                             
            if(count($groups)>0){
                $value['color']=$groups[0]['color']; 
                $value['image']=explode(',', $groups[0]['images'])[0];
            }
            else{
                    $value['color']=null; 
                    $value['image']=null;
            }

       }
       return ResponseBuilder::resultWithData((bool)$items!=null?true:false,'successfully',$items);

    }

    public function showOneItem($id, $userId){
    {
            $item = Item::find($id);
            $favourite = Favorate::where('user_id',$userId)->where('item_id',$item->id)->first();

            $item['liked']=$favourite != null;
            
            $images=Images::where('item_id',$item->id)->get();
            $groupImages=[];
            foreach ($images as $key => $image) {
                $allImages=explode(',', $image['images']);
                unset($allImages[count($allImages)-1]);
                $image['images']=$allImages;
            }
            $item["colorImages"] =$images;

            return ResponseBuilder::resultWithData((bool)$item!=null?true:false,'successfully',$item);
     
         }
    }

    /**
     * Show the form for editing the specified resource.
     *
     * @param  \App\Models\item  $item
     * @return \Illuminate\Http\Response
     */
    public function edit(item $item)
    {
        //
    }

    /**
     * Update the specified resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  \App\Models\item  $item
     * @return \Illuminate\Http\Response
     */
    public function update(Request $request, item $item)
    {
        //
    }

    /**
     * Remove the specified resource from storage.
     *
     * @param  \App\Models\item  $item
     * @return \Illuminate\Http\Response
     */
    public function destroy($id)
    {
        $destroy=Item::destroy($id);
        return ResponseBuilder::result((bool)$destroy,'successfully');
    }
}
