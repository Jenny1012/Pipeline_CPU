# Pipeline_CPU  
計算機組織Final Project  
109學年度第2學期  
  
  
	Datapath與詳細架構圖  
	完整Datapath  
 ![image](https://user-images.githubusercontent.com/64779422/193540518-642ac9c8-195e-463c-9847-ceeb85c0fd01.png)

	IF/ID  
 ![image](https://user-images.githubusercontent.com/64779422/193540537-c47929dc-17fb-4700-b3f2-90ce1b0bd174.png)

	IF/ID-ID/EX  
 ![image](https://user-images.githubusercontent.com/64779422/193540548-3c2d94df-e7f7-41a1-bc0f-1aee880a3d58.png)

	ID/EX-EX/MEM  
 ![image](https://user-images.githubusercontent.com/64779422/193540568-b9f55953-7197-423b-ab39-b04da121573f.png)

	EX/MEM-MEM/WB  
 ![image](https://user-images.githubusercontent.com/64779422/193540585-29a5aac4-7f6c-420a-a7a7-cee98c4bde10.png)

	MEM/WB  
 ![image](https://user-images.githubusercontent.com/64779422/193540595-e6ddac31-2031-4497-a43a-24f35a44d47b.png)


	設計重點說明  
	lw : 先在control_single進行必要之訊號賦值，使最後DataMemory的ADDR為rs，WD為rt，經過DataMemory後即可將ADDR(rs)指向之位置中的內容讀進去rt並寫回register。  
	sw : 先在control_single進行必要之訊號賦值，使最後DataMemory的ADDR為rs，WD為rt，經過DataMemory後即可將WD（rt)指向之位置中的資料寫進ADDR（rs）中。  
	addiu :類似於ADD，只是ADD是將rs的內容加上rt的內容寫回rd，而ADDIU則是將rs的內容加上immed寫回rt，因此只要確保進ALU時的inputA是rs、inputB是immed、最終DataMemory的WD是rt，其餘皆都和ADD相同。  
	multu : 利用funct來判斷是否進行乘法，一旦要進行乘法，必須stall 32個clock 才有辦法完成，故會有一個module來進行對PC以及IF_ID輸出部寫入訊號進行stall直到32 clock進行完成後，將會對HiLo輸出寫入信號，HILo將會把乘法的結果寫入，並且保持至下次的輸入信號輸入。  
	mfhi : rs以及rt均為零，並且沒有給一定要做的指令故ALU計算並不會有結果，僅需將ALU後的多工器給輸出訊號ALU_OUT 設為0,hi中的內容，不用經過data Memory而是直接將hi的內容寫回指定rd暫存器內即可。  
	mflo : rs以及rt均為零，並且沒有給一定要做的指令故ALU計算並不會有結果，僅需將ALU後的多工器給出輸出訊號ALU_OUT 設為1，輸出hi中的內容，不用經過data Memory而是直接將hi的內容寫回指定rd暫存器內即可。  
	j : 跳躍指令，控制訊號Jump設為1，將指令中低26位元指令偏移量左移2位元變成28位元位置偏移量，前面接上PC+4的最高4位元形成32位元，當作要跳去的位置。  
	jal : 前半部與j指令相同，但要將返回位置return address (PC+4)存在r31暫存器中，因為要寫回暫存器，所以將RegWrite設為1，MemtoReg設為2表示選擇PC+4作為寫入的內容，RegDst設為2表示選擇第31號暫存器寫入。  
	beq : 將指令中低16位元指令偏移量左移2位元變成18位元位置偏移量，並將它做有號數擴充成32位元，控制訊號Branch設為1，在Instruction Decode接段，將Register File輸出之RD1與RD2做比較，判斷是否相等，若相等，則Zero訊號設為1，否則Zero為0，利用Branch & Zero的結果設定PCSrc， PCSrc若為1則選擇(PC+4+位移量)作為下一個cycle的PC，若PCSrc為0，則選擇正常的PC+4。  
	nop :指令32位元全為0，不執行任何動作來達到stall的作用  


	Icarus Verilog驗證結果與Waveform輸出圖形  
	Icarus Verilog 驗證結果  
 ![image](https://user-images.githubusercontent.com/64779422/193540632-29e7beba-6131-46bc-8d6f-b9a08f8276e3.png)
 ![image](https://user-images.githubusercontent.com/64779422/193540694-21f4d226-e750-4620-8f58-78550b6fcea1.png)
 ![image](https://user-images.githubusercontent.com/64779422/193540706-649f6595-6b49-40d5-ae4f-0ab36c3d3306.png)
 ![image](https://user-images.githubusercontent.com/64779422/193540738-fe592b96-158b-44c2-945d-dd3409bd73e9.png)
 ![image](https://user-images.githubusercontent.com/64779422/193540758-547ca4a8-4a78-4861-a527-84c2049f2db9.png)
 ![image](https://user-images.githubusercontent.com/64779422/193540788-6be54706-8b77-4352-9628-dc585a7865a4.png)

  
	Waveform 輸出圖形  
  
add  
指令分析階段可看到rs = 〖11〗_16 , rt = 〖10〗_16  , rd = 〖11〗_16 ，進入ALU階段輸入訊號可為a = 2_16 ,b = 1_16做加法結果為result = 3_16結果正確，並且在下一階段把ALU的結果輸出寫回至rd = 〖11〗_16暫存器  
   
 ![image](https://user-images.githubusercontent.com/64779422/193540849-d13dd362-3094-492b-8ce6-4cf7b3e8b219.png)
   
sub  
指令分析階段可看到rs = 〖12〗_16 , rt = 〖10〗_16 , rd = 〖12〗_16，進入ALU階段輸入訊號可為a = 3_16 ,b = 1_16做減法結果為result = 2_16結果正確，並且在下一階段把ALU的結果輸出寫回至rd = 〖12〗_16暫存器  
   
 ![image](https://user-images.githubusercontent.com/64779422/193540871-3686d2b8-aa3c-4ed5-99a6-3c89674edf1a.png)
   
or  
指令分析階段可看到rs = 〖12〗_16 , rt = 〖10〗_16, rd = 〖12〗_16 ，進入ALU階段輸入訊號可為a = 3_16 = 〖0011〗_2 ,b = 1_16 = 〖0001〗_2做or結果為result = 3_16=〖0011〗_2 結果正確，並且在下一階段把ALU的結果輸出寫回至rd = 〖12〗_16暫存器  
   
 ![image](https://user-images.githubusercontent.com/64779422/193540895-eda1a675-99fb-453f-ba64-ad8b8161ec50.png)
   
and  
指令分析階段可看到rs = 〖12〗_16 , rt = 〖10〗_16 , rd = 〖12〗_16 ，進入ALU階段輸入訊號可為a = 3_16 = 〖0011〗_2 ,b = 1_16 = 〖0001〗_2做and結果為result = 1_16=〖0001〗_2 結果正確，並且在下一階段把ALU的結果輸出寫回rd = 〖12〗_16暫存器  
  
![image](https://user-images.githubusercontent.com/64779422/193540941-25a448a0-affb-441b-9202-d5f51e8ab37f.png)
  
multu  
可以一開始看到乘法指令進入乘法器為第7個clock 而最後輸出為第39 clock，期間直讓指令維持在進行乘法的位移及加法動作，並可以在32 clock完成結果後輸出給HiLo暫存器。由下圖可知乘法器是做〖12〗_16*〖13〗_16輸出結果為〖156〗_16 答案與模擬相同。  
  
![image](https://user-images.githubusercontent.com/64779422/193540966-894b9761-a599-459d-ba52-d5476763691b.png)
  
mfhi  
指令分析階段可看到rd = 〖OC〗_16，ALU_out為以hi, lo及ALU的選擇輸出後之結果而HiOut=O_16，進入下一階段的寫回，寫回到指定的rd = 〖OC〗_16 暫存器內。  
  
![image](https://user-images.githubusercontent.com/64779422/193540999-0bac6f06-5c22-42ce-8edc-9ca9cbb2b77b.png)
  
mflo  
指令分析階段可看到rd = 〖OD〗_16，ALU_out為以hi, lo及ALU的選擇輸出後之結果而LoOut=〖156〗_16，進入下一階段的寫回，寫回到指定的rd = 〖OD〗_16 暫存器內。  
  
![image](https://user-images.githubusercontent.com/64779422/193541029-f93e6370-2eff-4157-ac24-fa5b17f93a85.png)
  
lw  
Opcode=〖23〗_16（〖35〗_10）代表目前要執行LW指令，而此時的rs=〖11〗_16（〖17〗_10）、rt =〖0F〗_16（〖15〗_10）。而當addr=2_16時，其值為〖100〗_16（〖256〗_10），後看到WN=〖0F〗_16（〖15〗_10）且WD為〖100〗_16（〖256〗_10），代表要將WD的值存到第WN個暫存器中。  
   
 ![image](https://user-images.githubusercontent.com/64779422/193541052-ea331e9d-f1cf-4524-af95-50ef479ba217.png)
   
sw  
Opcode=〖2B〗_16（〖43〗_10）代表目前要執行SW指令，而此時的rs=0_16（1_10）、rt =〖12〗_16（〖18〗_10）。而當addr=〖18〗_16時，代表要將WD的值（3_16）放進第〖18〗_16個記憶體位置，又因他是sw，不必寫入暫存器，因此之後的rd、WN、WD都為未知訊號。  
   
 ![image](https://user-images.githubusercontent.com/64779422/193541075-a0c57c74-b653-41a6-b098-619f454d3d72.png)
   
addiu  
Opcode=9_16（9_10）代表目前要執行addiu指令，而此時的rs=〖0F〗_16（〖15〗_10）其值為〖100〗_16（〖256〗_10），此時的immed_out是1_16，經過ALU運算之結果為〖101〗_16（〖257〗_10），此時的addr雖為〖101〗_16，但由於MemWright、MemRead皆為0，故MEM/WB會直接將result回傳至register並寫入第WN個register。  
  
![image](https://user-images.githubusercontent.com/64779422/193541104-97b25b5b-2dc0-4000-8a64-4153e172457e.png)
  
beq  
指令分析階段可看到opcode = 4_16 rs = 〖11〗_16 , rt = 〖11〗_16，immed為3_16，左移兩位元在有號數擴充後會變為b_offset= C_16，則b_tgt就會是pc+4+b_offset = 〖14〗_16，比較兩個暫存器的值，若相同則設Zero為1，可知兩個暫存器的內容都是2_16，因此PCSrc = Zero & Branch的結果會是1，選擇b_tgt= 〖14〗_16當作下一cycle的pc。  
  
![image](https://user-images.githubusercontent.com/64779422/193541124-179baf20-aee9-4e02-96b0-6a7cd1f15448.png)
  
nop : 指令全為0，做stall  
  
![image](https://user-images.githubusercontent.com/64779422/193541155-71deab2b-d837-487c-b776-3f68b90edea0.png)
  
j  
指令分析階段可看到opcode = 2_16 jumpoffset = 〖15〗_16 , 將jumpoffset左移兩位元變成〖 84〗_16，前面再接上pc_incr的最高4位元(0_16) =〖84〗_16 做為要跳去的位置，由波形可知下一cycle的pc變為〖84〗_16，模擬結果正確。  
  
![image](https://user-images.githubusercontent.com/64779422/193541188-c347ad98-0cc3-412d-a4ea-758e5905925b.png)
  
jal  
指令分析階段可看到opcode = 3_16 jumpoffset = 7_16 , 將jumpoffset左移兩位元變成〖 1C〗_16，前面再接上pc_incr的最高4位元(0_16) =〖1C〗_16 做為要跳去的位置，因為要將return address寫回r31暫存器，所以設MemtoReg設為〖10〗_2表示選擇PC+4作為下一階段要寫入的內容，RegDst設為2表示WN選擇第〖1F〗_16=〖31〗_10號暫存器寫入。  
  
![image](https://user-images.githubusercontent.com/64779422/193541205-98bb1224-4882-4793-b374-0e094e12e3e4.png)
  
	心得感想  
通過這次的final project，讓我們對pipeline cpu的運作與verilog的撰寫有了一個更進階的認識與了解。在這次的作業中也是遇到了不少難關，比如pipeline的四個暫存器需要甚麼訊號、接出來register的訊號接不到、遇到hazard要怎麼處理、要怎麼接上ALU、乘法器訊號要怎麼給等等，透過與組員們們連續好幾天徹夜通話與討論，最後終於順利完成了這次的project。原本還在想說要怎麼分part給其他的組員，但是發現其實這次的project並不好拆，所以最後是通過大家的配合與努力，準時順利的完成了這次的挑戰。  



