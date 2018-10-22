package com.withdog.service.dogbreeddic.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import com.withdog.service.dogbreeddic.DogBreedDicDAO;
import com.withdog.service.dogbreeddic.DogBreedDicService;
import com.withdog.service.domain.DogBreedDic;

@Service("dogBreedDicServiceImpl")
public class DogBreedDicServiceImpl implements DogBreedDicService {

	@Autowired
	@Qualifier("dogBreedDicDAOImpl")
	private DogBreedDicDAO dogBreedDicDAO;

	public DogBreedDicServiceImpl() {
		System.out.println(this.getClass());
	}

	public void setdogBreedDicDAO(DogBreedDicDAO dogBreedDicDAO) {
		this.dogBreedDicDAO = dogBreedDicDAO;
	}

	@Override
	public DogBreedDic getDogBreedInfo(int dogNo) throws Exception { //¼ÒÇö´©³ª²¨
		return dogBreedDicDAO.getDogBreedInfo(dogNo);
	}

	@Override
	public List<DogBreedDic> getDogBreedInfoList(String dogBreedKo) throws Exception {
		// TODO Auto-generated method stub
		return dogBreedDicDAO.getDogBreedInfoList(dogBreedKo);
	}

	@Override
	public int addDogBreedInfo(DogBreedDic dogBreedDic) throws Exception {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public int updateDogBreedInfo(DogBreedDic dogBreedDic) throws Exception {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public int deleteDogBreedInfo(int dogNo) throws Exception {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public DogBreedDic getDogBreed(String dogBreedEN) throws Exception {
		return dogBreedDicDAO.getDogBreed(dogBreedEN);
	}

	@Override
	public List<DogBreedDic> getAllDogBreedInfoList() throws Exception {
		return dogBreedDicDAO.getAllDogBreedInfoList();
	}

	@Override
	public List<DogBreedDic> getAllDogBreedInfoListByKo() throws Exception {
		return dogBreedDicDAO.getAllDogBreedInfoListByKo();
	}

	@Override
	public List<DogBreedDic> getAllDogBreedNameListByKo() throws Exception {
		return dogBreedDicDAO.getAllDogBreedNameListByKo();
	}

}
