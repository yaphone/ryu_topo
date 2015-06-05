import copy
def com_weight(dic1,dic2):
    dic3 = copy.deepcopy(dic2)
    for i in dic1.keys():
        for j in dic1[i].keys():
            try:
                dic3[i][j]=abs(dic1[i][j]-dic2[i][j])
            except:
                pass

    return(dic3)

def add_edges_weight(dic1,list1):
    _weight=[]
    list1 = sorted(list1)
    
    for key1 in dic1:
        for key2 in dic1[key1]:
            _weight.append(dic1[key1][key2])
            
    for i in range(len(list1)):
        try:
            list1[i][2]['weight'] = _weight[i]
        except:
            list1[i][2]['weight'] = 1
#    print dic1
#    print list1

        
  

if __name__=='__main__':

    dic1 = {1: {1: 142299, 2: 142315}, 2: {3: 142188}, 3: {3: 142754}}
    dic2 = {1: {1: 142263, 2: 142312}, 2: {3: 142110}, 3: {3: 142722}}       

#    print ('__________________')
#    print (dic1)
#    print (dic2)
#    print ('*******************')
    
#    com_weight(dic1, dic2)
#    print ('~~~~~~~~~~~~~~~~~~~~~~~~')
#    print (dic1)
#    print (dic2)

    dic4 = {1: {1: 51, 2: 51}, 2: {1: 666949, 2: 715989567, 3: 51}, 3: {3: 715989567}, 4: {3: 666949}, 5: {1: 51, 2: 51, 3: 51}, 6: {3: 51}, 7: {3: 51}}
    list4 =[(2, 1, {'port': 3, 'weight': 51}), (5, 6, {'port': 1, 'weight': 51}), (4, 2, {'port': 3, 'weight': 51}), (7, 5, {'port': 3, 'weight': 51}), (2, 3, {'port': 1, 'weight': 51}), (1, 2, {'port': 1, 'weight': 51}), (3, 2, {'port': 3, 'weight': 51}), (5, 7, {'port': 2, 'weight': 51}), (1, 5, {'port': 2, 'weight': 51}), (6, 5, {'port': 3, 'weight': 51}), (5, 1, {'port': 3, 'weight': 51}), (2, 4, {'port': 2, 'weight': 51})]
    add_edges_weight(dic4, list4)
    
