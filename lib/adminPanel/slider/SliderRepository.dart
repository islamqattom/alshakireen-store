import 'dart:developer';
import 'package:alshakireen/adminPanel/Slider/SliderRequest.dart';
import 'package:alshakireen/adminPanel/slider/SliderModel.dart';
import 'package:alshakireen/utils/VariablesUtils.dart';
import 'package:alshakireen/utils/models/GeneralResponse.dart';
import 'package:http/http.dart' as http;

class SliderRepository {
  Future<GeneralResponse> addSlider(SliderRequest sliderRequest) async {
    String url = '${vUtils.baseUrl}addSlider';

    var response = await http.post(Uri.parse(url), body: sliderRequest.toJson(), headers: {
      "Accept": "application/json",
    });
    log(response.body);

    GeneralResponse generalResponse = GeneralResponse(success: false, information: 'error occurred');
    if (response.statusCode == 200) {
      generalResponse = generalResponseFromJson(response.body);
    }
    return generalResponse;
  }

  Future<SliderModel> getSlider() async {
    String url = '${vUtils.baseUrl}getSlider';

    var response = await http.get(Uri.parse(url));
    log(response.body.toString());

    SliderModel slider = SliderModel(success: false, information: 'error', data: null);
    if (response.statusCode == 200) {
      slider = sliderModelFromJson(response.body);
    }
    return slider;
  }
}

SliderRepository sRepository = SliderRepository();
