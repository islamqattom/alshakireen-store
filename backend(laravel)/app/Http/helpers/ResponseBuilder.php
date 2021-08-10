<?php
namespace App\Http\Helpers;

class ResponseBuilder{
    
    public static function result($status = "", $info = "", $data = "")
    {
        return response()->json([
            "success" => $status,
            "information" => $info,
        ], 200, ['Content-Type' => 'application/json;charset=UTF-8', 'Charset' => 'utf-8'], JSON_UNESCAPED_UNICODE);
    }

    public static function resultWithData($status = "", $info = "", $data = "")
    {
        return response()->json([
            "success" => $status,
            "information" => $info,
            "data" => $data,
        ], 200, ['Content-Type' => 'application/json;charset=UTF-8', 'Charset' => 'utf-8'], JSON_UNESCAPED_UNICODE);
    }

}

?>