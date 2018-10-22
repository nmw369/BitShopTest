package com.withdog.service.dogbreeddic;

import java.util.List;

import com.withdog.service.domain.DogBreedDic;

public interface DogBreedDicService {
	
	public DogBreedDic getDogBreedInfo(int dogNo) throws Exception;

	public DogBreedDic getDogBreed(String dogBreedEN) throws Exception;
	
	public List<DogBreedDic> getDogBreedInfoList(String dogBreedKO) throws Exception;
	
	public List<DogBreedDic> getAllDogBreedInfoList() throws Exception;
	
	public List<DogBreedDic> getAllDogBreedInfoListByKo() throws Exception;

	public List<DogBreedDic> getAllDogBreedNameListByKo() throws Exception;
	
	public int addDogBreedInfo(DogBreedDic dogBreedDic) throws Exception; // 包府磊
	
	public int updateDogBreedInfo(DogBreedDic dogBreedDic) throws Exception; // 包府磊
 	
	public int deleteDogBreedInfo(int dogNo) throws Exception; // 包府磊
}