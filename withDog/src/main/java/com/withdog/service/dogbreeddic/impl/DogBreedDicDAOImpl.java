package com.withdog.service.dogbreeddic.impl;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Repository;

import com.withdog.service.dogbreeddic.DogBreedDicDAO;
import com.withdog.service.domain.DogBreedDic;

@Repository("dogBreedDicDAOImpl")
public class DogBreedDicDAOImpl implements DogBreedDicDAO {
//
	@Autowired
	@Qualifier("sqlSessionTemplate")
	private SqlSession sqlSession;

	public void setSqlSession(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
	}

	public DogBreedDicDAOImpl() {
		System.out.println(this.getClass());
	}

	@Override
	public DogBreedDic getDogBreedInfo(int dogNo) throws Exception { //¼ÒÇö´©³ª²¨
		return sqlSession.selectOne("DogBreedDicMapper.getDogBreed2", dogNo);
	}

	@Override
	public DogBreedDic getDogBreed(String dogBreedEN) throws Exception {
		return sqlSession.selectOne("DogBreedDicMapper.getDogBreed", dogBreedEN);
	}
	
	@Override
	public List<DogBreedDic> getDogBreedInfoList(String dogBreedKO) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.selectList("DogBreedDicMapper.getDogBreedInfoList", dogBreedKO);
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
	public List<DogBreedDic> getAllDogBreedInfoList() throws Exception {
		return sqlSession.selectList("DogBreedDicMapper.getAllDogBreedInfoList");
	}

	@Override
	public List<DogBreedDic> getAllDogBreedInfoListByKo() throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.selectList("DogBreedDicMapper.getAllDogBreedInfoListByKo");
	}

	@Override
	public List<DogBreedDic> getAllDogBreedNameListByKo() throws Exception {
		return sqlSession.selectList("DogBreedDicMapper.getAllDogBreedNameListByKo");
	}

}
