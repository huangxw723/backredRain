package com.aoshi.controller.manage.consultation.excel;

import java.util.ArrayList;
import java.util.List;


import com.aoshi.domain.AsConsultationFood;


public class FoodConverter implements Converter<AsConsultationFood>{

	@Override
	public List<AsConsultationFood> convert(List<List<Object>> objects) {
		// TODO Auto-generated method stub
		List<AsConsultationFood> lists = new ArrayList<>();
		for(@SuppressWarnings("unused") List<Object> obj : objects){
			AsConsultationFood foods = new AsConsultationFood();
			lists.add(foods);
		}
		return lists;
	}

}
