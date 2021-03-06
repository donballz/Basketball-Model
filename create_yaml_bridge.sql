USE BBALL;
DROP TABLE IF EXISTS NBA_YAML_BRIDGE;
CREATE TABLE IF NOT EXISTS NBA_YAML_BRIDGE 
(FILE VARCHAR(12), FILE_CD VARCHAR(3), YEAR INT, TEAM VARCHAR(3)); 
INSERT INTO NBA_YAML_BRIDGE VALUES
('TOR_2001.yml','TOR',2001,'TOR'),
('TOR_2002.yml','TOR',2002,'TOR'),
('TOR_2003.yml','TOR',2003,'TOR'),
('TOR_2004.yml','TOR',2004,'TOR'),
('TOR_2005.yml','TOR',2005,'TOR'),
('TOR_2006.yml','TOR',2006,'TOR'),
('TOR_2007.yml','TOR',2007,'TOR'),
('TOR_2008.yml','TOR',2008,'TOR'),
('TOR_2009.yml','TOR',2009,'TOR'),
('TOR_2010.yml','TOR',2010,'TOR'),
('TOR_2011.yml','TOR',2011,'TOR'),
('TOR_2012.yml','TOR',2012,'TOR'),
('TOR_2013.yml','TOR',2013,'TOR'),
('TOR_2014.yml','TOR',2014,'TOR'),
('TOR_2015.yml','TOR',2015,'TOR'),
('TOR_2016.yml','TOR',2016,'TOR'),
('ATL_2001.yml','ATL',2001,'ATL'),
('ATL_2002.yml','ATL',2002,'ATL'),
('ATL_2003.yml','ATL',2003,'ATL'),
('ATL_2004.yml','ATL',2004,'ATL'),
('ATL_2005.yml','ATL',2005,'ATL'),
('ATL_2006.yml','ATL',2006,'ATL'),
('ATL_2007.yml','ATL',2007,'ATL'),
('ATL_2008.yml','ATL',2008,'ATL'),
('ATL_2009.yml','ATL',2009,'ATL'),
('ATL_2010.yml','ATL',2010,'ATL'),
('ATL_2011.yml','ATL',2011,'ATL'),
('ATL_2012.yml','ATL',2012,'ATL'),
('ATL_2013.yml','ATL',2013,'ATL'),
('ATL_2014.yml','ATL',2014,'ATL'),
('ATL_2015.yml','ATL',2015,'ATL'),
('ATL_2016.yml','ATL',2016,'ATL'),
('BOS_2001.yml','BOS',2001,'BOS'),
('BOS_2002.yml','BOS',2002,'BOS'),
('BOS_2003.yml','BOS',2003,'BOS'),
('BOS_2004.yml','BOS',2004,'BOS'),
('BOS_2005.yml','BOS',2005,'BOS'),
('BOS_2006.yml','BOS',2006,'BOS'),
('BOS_2007.yml','BOS',2007,'BOS'),
('BOS_2008.yml','BOS',2008,'BOS'),
('BOS_2009.yml','BOS',2009,'BOS'),
('BOS_2010.yml','BOS',2010,'BOS'),
('BOS_2011.yml','BOS',2011,'BOS'),
('BOS_2012.yml','BOS',2012,'BOS'),
('BOS_2013.yml','BOS',2013,'BOS'),
('BOS_2014.yml','BOS',2014,'BOS'),
('BOS_2015.yml','BOS',2015,'BOS'),
('BOS_2016.yml','BOS',2016,'BOS'),
('CHI_2001.yml','CHI',2001,'CHI'),
('CHI_2002.yml','CHI',2002,'CHI'),
('CHI_2003.yml','CHI',2003,'CHI'),
('CHI_2004.yml','CHI',2004,'CHI'),
('CHI_2005.yml','CHI',2005,'CHI'),
('CHI_2006.yml','CHI',2006,'CHI'),
('CHI_2007.yml','CHI',2007,'CHI'),
('CHI_2008.yml','CHI',2008,'CHI'),
('CHI_2009.yml','CHI',2009,'CHI'),
('CHI_2010.yml','CHI',2010,'CHI'),
('CHI_2011.yml','CHI',2011,'CHI'),
('CHI_2012.yml','CHI',2012,'CHI'),
('CHI_2013.yml','CHI',2013,'CHI'),
('CHI_2014.yml','CHI',2014,'CHI'),
('CHI_2015.yml','CHI',2015,'CHI'),
('CHI_2016.yml','CHI',2016,'CHI'),
('CHH_2001.yml','CHH',2001,'CHA'),
('CHH_2002.yml','CHH',2002,'CHA'),
('CHA_2005.yml','CHA',2005,'CHA'),
('CHA_2006.yml','CHA',2006,'CHA'),
('CHA_2007.yml','CHA',2007,'CHA'),
('CHA_2008.yml','CHA',2008,'CHA'),
('CHA_2009.yml','CHA',2009,'CHA'),
('CHA_2010.yml','CHA',2010,'CHA'),
('CHA_2011.yml','CHA',2011,'CHA'),
('CHA_2012.yml','CHA',2012,'CHA'),
('CHA_2013.yml','CHA',2013,'CHA'),
('CHA_2014.yml','CHA',2014,'CHA'),
('CHO_2015.yml','CHO',2015,'CHA'),
('CHO_2016.yml','CHO',2016,'CHA'),
('CLE_2001.yml','CLE',2001,'CLE'),
('CLE_2002.yml','CLE',2002,'CLE'),
('CLE_2003.yml','CLE',2003,'CLE'),
('CLE_2004.yml','CLE',2004,'CLE'),
('CLE_2005.yml','CLE',2005,'CLE'),
('CLE_2006.yml','CLE',2006,'CLE'),
('CLE_2007.yml','CLE',2007,'CLE'),
('CLE_2008.yml','CLE',2008,'CLE'),
('CLE_2009.yml','CLE',2009,'CLE'),
('CLE_2010.yml','CLE',2010,'CLE'),
('CLE_2011.yml','CLE',2011,'CLE'),
('CLE_2012.yml','CLE',2012,'CLE'),
('CLE_2013.yml','CLE',2013,'CLE'),
('CLE_2014.yml','CLE',2014,'CLE'),
('CLE_2015.yml','CLE',2015,'CLE'),
('CLE_2016.yml','CLE',2016,'CLE'),
('DAL_2001.yml','DAL',2001,'DAL'),
('DAL_2002.yml','DAL',2002,'DAL'),
('DAL_2003.yml','DAL',2003,'DAL'),
('DAL_2004.yml','DAL',2004,'DAL'),
('DAL_2005.yml','DAL',2005,'DAL'),
('DAL_2006.yml','DAL',2006,'DAL'),
('DAL_2007.yml','DAL',2007,'DAL'),
('DAL_2008.yml','DAL',2008,'DAL'),
('DAL_2009.yml','DAL',2009,'DAL'),
('DAL_2010.yml','DAL',2010,'DAL'),
('DAL_2011.yml','DAL',2011,'DAL'),
('DAL_2012.yml','DAL',2012,'DAL'),
('DAL_2013.yml','DAL',2013,'DAL'),
('DAL_2014.yml','DAL',2014,'DAL'),
('DAL_2015.yml','DAL',2015,'DAL'),
('DAL_2016.yml','DAL',2016,'DAL'),
('DEN_2001.yml','DEN',2001,'DEN'),
('DEN_2002.yml','DEN',2002,'DEN'),
('DEN_2003.yml','DEN',2003,'DEN'),
('DEN_2004.yml','DEN',2004,'DEN'),
('DEN_2005.yml','DEN',2005,'DEN'),
('DEN_2006.yml','DEN',2006,'DEN'),
('DEN_2007.yml','DEN',2007,'DEN'),
('DEN_2008.yml','DEN',2008,'DEN'),
('DEN_2009.yml','DEN',2009,'DEN'),
('DEN_2010.yml','DEN',2010,'DEN'),
('DEN_2011.yml','DEN',2011,'DEN'),
('DEN_2012.yml','DEN',2012,'DEN'),
('DEN_2013.yml','DEN',2013,'DEN'),
('DEN_2014.yml','DEN',2014,'DEN'),
('DEN_2015.yml','DEN',2015,'DEN'),
('DEN_2016.yml','DEN',2016,'DEN'),
('DET_2001.yml','DET',2001,'DET'),
('DET_2002.yml','DET',2002,'DET'),
('DET_2003.yml','DET',2003,'DET'),
('DET_2004.yml','DET',2004,'DET'),
('DET_2005.yml','DET',2005,'DET'),
('DET_2006.yml','DET',2006,'DET'),
('DET_2007.yml','DET',2007,'DET'),
('DET_2008.yml','DET',2008,'DET'),
('DET_2009.yml','DET',2009,'DET'),
('DET_2010.yml','DET',2010,'DET'),
('DET_2011.yml','DET',2011,'DET'),
('DET_2012.yml','DET',2012,'DET'),
('DET_2013.yml','DET',2013,'DET'),
('DET_2014.yml','DET',2014,'DET'),
('DET_2015.yml','DET',2015,'DET'),
('DET_2016.yml','DET',2016,'DET'),
('GSW_2001.yml','GSW',2001,'GSW'),
('GSW_2002.yml','GSW',2002,'GSW'),
('GSW_2003.yml','GSW',2003,'GSW'),
('GSW_2004.yml','GSW',2004,'GSW'),
('GSW_2005.yml','GSW',2005,'GSW'),
('GSW_2006.yml','GSW',2006,'GSW'),
('GSW_2007.yml','GSW',2007,'GSW'),
('GSW_2008.yml','GSW',2008,'GSW'),
('GSW_2009.yml','GSW',2009,'GSW'),
('GSW_2010.yml','GSW',2010,'GSW'),
('GSW_2011.yml','GSW',2011,'GSW'),
('GSW_2012.yml','GSW',2012,'GSW'),
('GSW_2013.yml','GSW',2013,'GSW'),
('GSW_2014.yml','GSW',2014,'GSW'),
('GSW_2015.yml','GSW',2015,'GSW'),
('GSW_2016.yml','GSW',2016,'GSW'),
('HOU_2001.yml','HOU',2001,'HOU'),
('HOU_2002.yml','HOU',2002,'HOU'),
('HOU_2003.yml','HOU',2003,'HOU'),
('HOU_2004.yml','HOU',2004,'HOU'),
('HOU_2005.yml','HOU',2005,'HOU'),
('HOU_2006.yml','HOU',2006,'HOU'),
('HOU_2007.yml','HOU',2007,'HOU'),
('HOU_2008.yml','HOU',2008,'HOU'),
('HOU_2009.yml','HOU',2009,'HOU'),
('HOU_2010.yml','HOU',2010,'HOU'),
('HOU_2011.yml','HOU',2011,'HOU'),
('HOU_2012.yml','HOU',2012,'HOU'),
('HOU_2013.yml','HOU',2013,'HOU'),
('HOU_2014.yml','HOU',2014,'HOU'),
('HOU_2015.yml','HOU',2015,'HOU'),
('HOU_2016.yml','HOU',2016,'HOU'),
('IND_2001.yml','IND',2001,'IND'),
('IND_2002.yml','IND',2002,'IND'),
('IND_2003.yml','IND',2003,'IND'),
('IND_2004.yml','IND',2004,'IND'),
('IND_2005.yml','IND',2005,'IND'),
('IND_2006.yml','IND',2006,'IND'),
('IND_2007.yml','IND',2007,'IND'),
('IND_2008.yml','IND',2008,'IND'),
('IND_2009.yml','IND',2009,'IND'),
('IND_2010.yml','IND',2010,'IND'),
('IND_2011.yml','IND',2011,'IND'),
('IND_2012.yml','IND',2012,'IND'),
('IND_2013.yml','IND',2013,'IND'),
('IND_2014.yml','IND',2014,'IND'),
('IND_2015.yml','IND',2015,'IND'),
('IND_2016.yml','IND',2016,'IND'),
('LAC_2001.yml','LAC',2001,'LAC'),
('LAC_2002.yml','LAC',2002,'LAC'),
('LAC_2003.yml','LAC',2003,'LAC'),
('LAC_2004.yml','LAC',2004,'LAC'),
('LAC_2005.yml','LAC',2005,'LAC'),
('LAC_2006.yml','LAC',2006,'LAC'),
('LAC_2007.yml','LAC',2007,'LAC'),
('LAC_2008.yml','LAC',2008,'LAC'),
('LAC_2009.yml','LAC',2009,'LAC'),
('LAC_2010.yml','LAC',2010,'LAC'),
('LAC_2011.yml','LAC',2011,'LAC'),
('LAC_2012.yml','LAC',2012,'LAC'),
('LAC_2013.yml','LAC',2013,'LAC'),
('LAC_2014.yml','LAC',2014,'LAC'),
('LAC_2015.yml','LAC',2015,'LAC'),
('LAC_2016.yml','LAC',2016,'LAC'),
('LAL_2001.yml','LAL',2001,'LAL'),
('LAL_2002.yml','LAL',2002,'LAL'),
('LAL_2003.yml','LAL',2003,'LAL'),
('LAL_2004.yml','LAL',2004,'LAL'),
('LAL_2005.yml','LAL',2005,'LAL'),
('LAL_2006.yml','LAL',2006,'LAL'),
('LAL_2007.yml','LAL',2007,'LAL'),
('LAL_2008.yml','LAL',2008,'LAL'),
('LAL_2009.yml','LAL',2009,'LAL'),
('LAL_2010.yml','LAL',2010,'LAL'),
('LAL_2011.yml','LAL',2011,'LAL'),
('LAL_2012.yml','LAL',2012,'LAL'),
('LAL_2013.yml','LAL',2013,'LAL'),
('LAL_2014.yml','LAL',2014,'LAL'),
('LAL_2015.yml','LAL',2015,'LAL'),
('LAL_2016.yml','LAL',2016,'LAL'),
('VAN_2001.yml','VAN',2001,'MEM'),
('MEM_2002.yml','MEM',2002,'MEM'),
('MEM_2003.yml','MEM',2003,'MEM'),
('MEM_2004.yml','MEM',2004,'MEM'),
('MEM_2005.yml','MEM',2005,'MEM'),
('MEM_2006.yml','MEM',2006,'MEM'),
('MEM_2007.yml','MEM',2007,'MEM'),
('MEM_2008.yml','MEM',2008,'MEM'),
('MEM_2009.yml','MEM',2009,'MEM'),
('MEM_2010.yml','MEM',2010,'MEM'),
('MEM_2011.yml','MEM',2011,'MEM'),
('MEM_2012.yml','MEM',2012,'MEM'),
('MEM_2013.yml','MEM',2013,'MEM'),
('MEM_2014.yml','MEM',2014,'MEM'),
('MEM_2015.yml','MEM',2015,'MEM'),
('MEM_2016.yml','MEM',2016,'MEM'),
('MIA_2001.yml','MIA',2001,'MIA'),
('MIA_2002.yml','MIA',2002,'MIA'),
('MIA_2003.yml','MIA',2003,'MIA'),
('MIA_2004.yml','MIA',2004,'MIA'),
('MIA_2005.yml','MIA',2005,'MIA'),
('MIA_2006.yml','MIA',2006,'MIA'),
('MIA_2007.yml','MIA',2007,'MIA'),
('MIA_2008.yml','MIA',2008,'MIA'),
('MIA_2009.yml','MIA',2009,'MIA'),
('MIA_2010.yml','MIA',2010,'MIA'),
('MIA_2011.yml','MIA',2011,'MIA'),
('MIA_2012.yml','MIA',2012,'MIA'),
('MIA_2013.yml','MIA',2013,'MIA'),
('MIA_2014.yml','MIA',2014,'MIA'),
('MIA_2015.yml','MIA',2015,'MIA'),
('MIA_2016.yml','MIA',2016,'MIA'),
('MIL_2001.yml','MIL',2001,'MIL'),
('MIL_2002.yml','MIL',2002,'MIL'),
('MIL_2003.yml','MIL',2003,'MIL'),
('MIL_2004.yml','MIL',2004,'MIL'),
('MIL_2005.yml','MIL',2005,'MIL'),
('MIL_2006.yml','MIL',2006,'MIL'),
('MIL_2007.yml','MIL',2007,'MIL'),
('MIL_2008.yml','MIL',2008,'MIL'),
('MIL_2009.yml','MIL',2009,'MIL'),
('MIL_2010.yml','MIL',2010,'MIL'),
('MIL_2011.yml','MIL',2011,'MIL'),
('MIL_2012.yml','MIL',2012,'MIL'),
('MIL_2013.yml','MIL',2013,'MIL'),
('MIL_2014.yml','MIL',2014,'MIL'),
('MIL_2015.yml','MIL',2015,'MIL'),
('MIL_2016.yml','MIL',2016,'MIL'),
('MIN_2001.yml','MIN',2001,'MIN'),
('MIN_2002.yml','MIN',2002,'MIN'),
('MIN_2003.yml','MIN',2003,'MIN'),
('MIN_2004.yml','MIN',2004,'MIN'),
('MIN_2005.yml','MIN',2005,'MIN'),
('MIN_2006.yml','MIN',2006,'MIN'),
('MIN_2007.yml','MIN',2007,'MIN'),
('MIN_2008.yml','MIN',2008,'MIN'),
('MIN_2009.yml','MIN',2009,'MIN'),
('MIN_2010.yml','MIN',2010,'MIN'),
('MIN_2011.yml','MIN',2011,'MIN'),
('MIN_2012.yml','MIN',2012,'MIN'),
('MIN_2013.yml','MIN',2013,'MIN'),
('MIN_2014.yml','MIN',2014,'MIN'),
('MIN_2015.yml','MIN',2015,'MIN'),
('MIN_2016.yml','MIN',2016,'MIN'),
('NJN_2001.yml','NJN',2001,'NJN'),
('NJN_2002.yml','NJN',2002,'NJN'),
('NJN_2003.yml','NJN',2003,'NJN'),
('NJN_2004.yml','NJN',2004,'NJN'),
('NJN_2005.yml','NJN',2005,'NJN'),
('NJN_2006.yml','NJN',2006,'NJN'),
('NJN_2007.yml','NJN',2007,'NJN'),
('NJN_2008.yml','NJN',2008,'NJN'),
('NJN_2009.yml','NJN',2009,'NJN'),
('NJN_2010.yml','NJN',2010,'NJN'),
('NJN_2011.yml','NJN',2011,'NJN'),
('NJN_2012.yml','NJN',2012,'NJN'),
('BRK_2013.yml','BRK',2013,'NJN'),
('BRK_2014.yml','BRK',2014,'NJN'),
('BRK_2015.yml','BRK',2015,'NJN'),
('BRK_2016.yml','BRK',2016,'NJN'),
('NOH_2003.yml','NOH',2003,'NOH'),
('NOH_2004.yml','NOH',2004,'NOH'),
('NOH_2005.yml','NOH',2005,'NOH'),
('NOK_2006.yml','NOK',2006,'NOH'),
('NOK_2007.yml','NOK',2007,'NOH'),
('NOH_2008.yml','NOH',2008,'NOH'),
('NOH_2009.yml','NOH',2009,'NOH'),
('NOH_2010.yml','NOH',2010,'NOH'),
('NOH_2011.yml','NOH',2011,'NOH'),
('NOH_2012.yml','NOH',2012,'NOH'),
('NOH_2013.yml','NOH',2013,'NOH'),
('NOP_2014.yml','NOP',2014,'NOH'),
('NOP_2015.yml','NOP',2015,'NOH'),
('NOP_2016.yml','NOP',2016,'NOH'),
('NYK_2001.yml','NYK',2001,'NYK'),
('NYK_2002.yml','NYK',2002,'NYK'),
('NYK_2003.yml','NYK',2003,'NYK'),
('NYK_2004.yml','NYK',2004,'NYK'),
('NYK_2005.yml','NYK',2005,'NYK'),
('NYK_2006.yml','NYK',2006,'NYK'),
('NYK_2007.yml','NYK',2007,'NYK'),
('NYK_2008.yml','NYK',2008,'NYK'),
('NYK_2009.yml','NYK',2009,'NYK'),
('NYK_2010.yml','NYK',2010,'NYK'),
('NYK_2011.yml','NYK',2011,'NYK'),
('NYK_2012.yml','NYK',2012,'NYK'),
('NYK_2013.yml','NYK',2013,'NYK'),
('NYK_2014.yml','NYK',2014,'NYK'),
('NYK_2015.yml','NYK',2015,'NYK'),
('NYK_2016.yml','NYK',2016,'NYK'),
('SEA_2001.yml','SEA',2001,'OKC'),
('SEA_2002.yml','SEA',2002,'OKC'),
('SEA_2003.yml','SEA',2003,'OKC'),
('SEA_2004.yml','SEA',2004,'OKC'),
('SEA_2005.yml','SEA',2005,'OKC'),
('SEA_2006.yml','SEA',2006,'OKC'),
('SEA_2007.yml','SEA',2007,'OKC'),
('SEA_2008.yml','SEA',2008,'OKC'),
('OKC_2009.yml','OKC',2009,'OKC'),
('OKC_2010.yml','OKC',2010,'OKC'),
('OKC_2011.yml','OKC',2011,'OKC'),
('OKC_2012.yml','OKC',2012,'OKC'),
('OKC_2013.yml','OKC',2013,'OKC'),
('OKC_2014.yml','OKC',2014,'OKC'),
('OKC_2015.yml','OKC',2015,'OKC'),
('OKC_2016.yml','OKC',2016,'OKC'),
('ORL_2001.yml','ORL',2001,'ORL'),
('ORL_2002.yml','ORL',2002,'ORL'),
('ORL_2003.yml','ORL',2003,'ORL'),
('ORL_2004.yml','ORL',2004,'ORL'),
('ORL_2005.yml','ORL',2005,'ORL'),
('ORL_2006.yml','ORL',2006,'ORL'),
('ORL_2007.yml','ORL',2007,'ORL'),
('ORL_2008.yml','ORL',2008,'ORL'),
('ORL_2009.yml','ORL',2009,'ORL'),
('ORL_2010.yml','ORL',2010,'ORL'),
('ORL_2011.yml','ORL',2011,'ORL'),
('ORL_2012.yml','ORL',2012,'ORL'),
('ORL_2013.yml','ORL',2013,'ORL'),
('ORL_2014.yml','ORL',2014,'ORL'),
('ORL_2015.yml','ORL',2015,'ORL'),
('ORL_2016.yml','ORL',2016,'ORL'),
('PHI_2001.yml','PHI',2001,'PHI'),
('PHI_2002.yml','PHI',2002,'PHI'),
('PHI_2003.yml','PHI',2003,'PHI'),
('PHI_2004.yml','PHI',2004,'PHI'),
('PHI_2005.yml','PHI',2005,'PHI'),
('PHI_2006.yml','PHI',2006,'PHI'),
('PHI_2007.yml','PHI',2007,'PHI'),
('PHI_2008.yml','PHI',2008,'PHI'),
('PHI_2009.yml','PHI',2009,'PHI'),
('PHI_2010.yml','PHI',2010,'PHI'),
('PHI_2011.yml','PHI',2011,'PHI'),
('PHI_2012.yml','PHI',2012,'PHI'),
('PHI_2013.yml','PHI',2013,'PHI'),
('PHI_2014.yml','PHI',2014,'PHI'),
('PHI_2015.yml','PHI',2015,'PHI'),
('PHI_2016.yml','PHI',2016,'PHI'),
('PHO_2001.yml','PHO',2001,'PHO'),
('PHO_2002.yml','PHO',2002,'PHO'),
('PHO_2003.yml','PHO',2003,'PHO'),
('PHO_2004.yml','PHO',2004,'PHO'),
('PHO_2005.yml','PHO',2005,'PHO'),
('PHO_2006.yml','PHO',2006,'PHO'),
('PHO_2007.yml','PHO',2007,'PHO'),
('PHO_2008.yml','PHO',2008,'PHO'),
('PHO_2009.yml','PHO',2009,'PHO'),
('PHO_2010.yml','PHO',2010,'PHO'),
('PHO_2011.yml','PHO',2011,'PHO'),
('PHO_2012.yml','PHO',2012,'PHO'),
('PHO_2013.yml','PHO',2013,'PHO'),
('PHO_2014.yml','PHO',2014,'PHO'),
('PHO_2015.yml','PHO',2015,'PHO'),
('PHO_2016.yml','PHO',2016,'PHO'),
('POR_2001.yml','POR',2001,'POR'),
('POR_2002.yml','POR',2002,'POR'),
('POR_2003.yml','POR',2003,'POR'),
('POR_2004.yml','POR',2004,'POR'),
('POR_2005.yml','POR',2005,'POR'),
('POR_2006.yml','POR',2006,'POR'),
('POR_2007.yml','POR',2007,'POR'),
('POR_2008.yml','POR',2008,'POR'),
('POR_2009.yml','POR',2009,'POR'),
('POR_2010.yml','POR',2010,'POR'),
('POR_2011.yml','POR',2011,'POR'),
('POR_2012.yml','POR',2012,'POR'),
('POR_2013.yml','POR',2013,'POR'),
('POR_2014.yml','POR',2014,'POR'),
('POR_2015.yml','POR',2015,'POR'),
('POR_2016.yml','POR',2016,'POR'),
('SAC_2001.yml','SAC',2001,'SAC'),
('SAC_2002.yml','SAC',2002,'SAC'),
('SAC_2003.yml','SAC',2003,'SAC'),
('SAC_2004.yml','SAC',2004,'SAC'),
('SAC_2005.yml','SAC',2005,'SAC'),
('SAC_2006.yml','SAC',2006,'SAC'),
('SAC_2007.yml','SAC',2007,'SAC'),
('SAC_2008.yml','SAC',2008,'SAC'),
('SAC_2009.yml','SAC',2009,'SAC'),
('SAC_2010.yml','SAC',2010,'SAC'),
('SAC_2011.yml','SAC',2011,'SAC'),
('SAC_2012.yml','SAC',2012,'SAC'),
('SAC_2013.yml','SAC',2013,'SAC'),
('SAC_2014.yml','SAC',2014,'SAC'),
('SAC_2015.yml','SAC',2015,'SAC'),
('SAC_2016.yml','SAC',2016,'SAC'),
('SAS_2001.yml','SAS',2001,'SAS'),
('SAS_2002.yml','SAS',2002,'SAS'),
('SAS_2003.yml','SAS',2003,'SAS'),
('SAS_2004.yml','SAS',2004,'SAS'),
('SAS_2005.yml','SAS',2005,'SAS'),
('SAS_2006.yml','SAS',2006,'SAS'),
('SAS_2007.yml','SAS',2007,'SAS'),
('SAS_2008.yml','SAS',2008,'SAS'),
('SAS_2009.yml','SAS',2009,'SAS'),
('SAS_2010.yml','SAS',2010,'SAS'),
('SAS_2011.yml','SAS',2011,'SAS'),
('SAS_2012.yml','SAS',2012,'SAS'),
('SAS_2013.yml','SAS',2013,'SAS'),
('SAS_2014.yml','SAS',2014,'SAS'),
('SAS_2015.yml','SAS',2015,'SAS'),
('SAS_2016.yml','SAS',2016,'SAS'),
('UTA_2001.yml','UTA',2001,'UTA'),
('UTA_2002.yml','UTA',2002,'UTA'),
('UTA_2003.yml','UTA',2003,'UTA'),
('UTA_2004.yml','UTA',2004,'UTA'),
('UTA_2005.yml','UTA',2005,'UTA'),
('UTA_2006.yml','UTA',2006,'UTA'),
('UTA_2007.yml','UTA',2007,'UTA'),
('UTA_2008.yml','UTA',2008,'UTA'),
('UTA_2009.yml','UTA',2009,'UTA'),
('UTA_2010.yml','UTA',2010,'UTA'),
('UTA_2011.yml','UTA',2011,'UTA'),
('UTA_2012.yml','UTA',2012,'UTA'),
('UTA_2013.yml','UTA',2013,'UTA'),
('UTA_2014.yml','UTA',2014,'UTA'),
('UTA_2015.yml','UTA',2015,'UTA'),
('UTA_2016.yml','UTA',2016,'UTA'),
('WAS_2001.yml','WAS',2001,'WAS'),
('WAS_2002.yml','WAS',2002,'WAS'),
('WAS_2003.yml','WAS',2003,'WAS'),
('WAS_2004.yml','WAS',2004,'WAS'),
('WAS_2005.yml','WAS',2005,'WAS'),
('WAS_2006.yml','WAS',2006,'WAS'),
('WAS_2007.yml','WAS',2007,'WAS'),
('WAS_2008.yml','WAS',2008,'WAS'),
('WAS_2009.yml','WAS',2009,'WAS'),
('WAS_2010.yml','WAS',2010,'WAS'),
('WAS_2011.yml','WAS',2011,'WAS'),
('WAS_2012.yml','WAS',2012,'WAS'),
('WAS_2013.yml','WAS',2013,'WAS'),
('WAS_2014.yml','WAS',2014,'WAS'),
('WAS_2015.yml','WAS',2015,'WAS'),
('WAS_2016.yml','WAS',2016,'WAS');