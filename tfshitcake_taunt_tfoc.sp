#pragma semicolon 1

#include <sdktools>
#include <tf2items>
#include <tf2_stocks>

#define PLUGIN_VERSION "1.2"

public Plugin:myinfo =
{
	name = "[TF2] Taunt TFOC",
	author = "pu_shitcake",
	description = "Free taunts for all, who don't love free thing?",
	version = PLUGIN_VERSION,
	url = "http://tfoc.maxnus.com/"
};

new Handle:hPlayTaunt;

public OnPluginStart()
{
	new Handle:conf = LoadGameConfigFile("tf2.tauntem");
	
	if (conf == INVALID_HANDLE)
	{
		SetFailState("Unable to load gamedata/tf2.tauntem.txt.");
		return;
	}
	
	StartPrepSDKCall(SDKCall_Player);
	PrepSDKCall_SetFromConf(conf, SDKConf_Signature, "CTFPlayer::PlayTauntSceneFromItem");
	PrepSDKCall_AddParameter(SDKType_PlainOldData, SDKPass_Plain);
	PrepSDKCall_SetReturnInfo(SDKType_Bool, SDKPass_Plain);
	hPlayTaunt = EndPrepSDKCall();
	
	if (hPlayTaunt == INVALID_HANDLE)
	{
		SetFailState("Unable to initialize call to CTFPlayer::PlayTauntSceneFromItem. Wait patiently for a fix.");
		CloseHandle(conf);
		return;
	}
	
	RegConsoleCmd("sm_taunt", Cmd_TauntMenu, "Taunt Menu");
	RegConsoleCmd("sm_taunts", Cmd_TauntMenu, "Taunt Menu");
	
	CloseHandle(conf);
	LoadTranslations("common.phrases");
	CreateConVar("tf_tauntem_version", PLUGIN_VERSION, "[TF2] Taunt 'em Version", FCVAR_NOTIFY|FCVAR_PLUGIN);
}

public Action:Cmd_TauntMenu(client, args)
{

	ShowMenu(client);
	
	return Plugin_Handled;
}

public Action:ShowMenu(client)
{
	new TFClassType:class = TF2_GetPlayerClass(client);
	new Handle:menu = CreateMenu(Tauntme_MenuSelected);
	SetMenuTitle(menu, "[TFOC] Taunts:");
	
	switch(class)
	{
		case TFClass_Scout:
		{
			AddMenuItem(menu, "1117", "(Scout) Battin' a Thousand");
			AddMenuItem(menu, "30572", "(Scout) Boston Breakdance");
			AddMenuItem(menu, "1119", "(Scout) Deep Fried Desire");
			AddMenuItem(menu, "30921", "(Scout) Runner's Rhythm");
			AddMenuItem(menu, "31161", "(Scout) Spin-to-Win");
			AddMenuItem(menu, "31156", "(Scout) The Boston Boarder");
			AddMenuItem(menu, "30920", "(Scout) The Bunnyhopper");
			AddMenuItem(menu, "1168", "(Scout) The Carlton");
			AddMenuItem(menu, "31233", "(Scout) The Homerunner's Hobby");
			AddMenuItem(menu, "30917", "(Scout) The Trackman's Touchdown");
		}
		case TFClass_Sniper:
		{
			AddMenuItem(menu, "30839", "(Sniper) Didgeridrongo");
			AddMenuItem(menu, "1116", "(Sniper) I See You");
            AddMenuItem(menu, "30609", "(Sniper) Killer Solo");
            AddMenuItem(menu, "30614", "(Sniper) Most Wanted");
			AddMenuItem(menu, "31237", "(Sniper) Shooter's Stakeout");
		}
		case TFClass_Soldier:
		{
			AddMenuItem(menu, "1113", "(Soldier) Fresh Brewed Victory");
			AddMenuItem(menu, "1196", "(Soldier) Panzer Pants");
			AddMenuItem(menu, "31155", "(Soldier) Rocket Jockey");
			AddMenuItem(menu, "30673", "(Soldier) Soldier's Requiem");
			AddMenuItem(menu, "30761", "(Soldier) The Fubar Fanfare");
			AddMenuItem(menu, "31202", "(Soldier) The Profane Puppeteer");
		}
		case TFClass_DemoMan:
		{
			AddMenuItem(menu, "1120", "(Demoman) Oblooterated");
			AddMenuItem(menu, "1114", "(Demoman) Spent Well Spirits");
			AddMenuItem(menu, "31201", "(Demoman) The Drunken Sailor");
			AddMenuItem(menu, "31153", "(Demoman) The Pooped Deck");
			AddMenuItem(menu, "30671", "(Demoman) True Scotsman's Call");
		}
		case TFClass_Medic:
		{
			AddMenuItem(menu, "31236", "(Medic) Doctor's Defibrillators");
			AddMenuItem(menu, "477", "(Medic) Meet the Medic");
			AddMenuItem(menu, "1109", "(Medic) Results Are In");
			AddMenuItem(menu, "30918", "(Medic) Surgeon's Squeezebox");
			AddMenuItem(menu, "31203", "(Medic) The Mannbulance!");
			AddMenuItem(menu, "31154", "(Medic) Time Out Therapy");
		}	
		case TFClass_Pyro:
		{
			AddMenuItem(menu, "1112", "(Pyro) Party Trick");
            AddMenuItem(menu, "30570", "(Pyro) Pool Party");
			AddMenuItem(menu, "31157", "(Pyro) Scorcher's Solo");
			AddMenuItem(menu, "30763", "(Pyro) The Balloonibouncer");
			AddMenuItem(menu, "30876", "(Pyro) The Headcase");
			AddMenuItem(menu, "31239", "(Pyro) The Hot Wheeler");
			AddMenuItem(menu, "1197", "(Pyro) The Scooty Scoot");
			AddMenuItem(menu, "30919", "(Pyro) The Skating Scorcher");
		}
		case TFClass_Spy:
		{
			AddMenuItem(menu, "1108", "(Spy) Buy A Life");
			AddMenuItem(menu, "30762", "(Spy) Disco Fever");
			AddMenuItem(menu, "30922", "(Spy) Luxury Lounge");
			AddMenuItem(menu, "30615", "(Spy) The Boxtrot");
		}
		case TFClass_Engineer:
		{
			AddMenuItem(menu, "30618", "(Engineer) Bucking Bronco");
			AddMenuItem(menu, "1115", "(Engineer) Rancho Relaxo");
			AddMenuItem(menu, "31160", "(Engineer) Texas Truckin'");
			AddMenuItem(menu, "30842", "(Engineer) The Dueling Banjo");
			AddMenuItem(menu, "30845", "(Engineer) The Jumping Jack");
		}
		case TFClass_Heavy:
		{
			AddMenuItem(menu, "31207", "(Heavy) Bare Knuckle Beatdown");
			AddMenuItem(menu, "30616", "(Heavy) Proletariat Showoff");
			AddMenuItem(menu, "1175", "(Heavy) The Boiling Point");
			AddMenuItem(menu, "30616", "(Heavy) The Proletariat Showoff");
			AddMenuItem(menu, "30843", "(Heavy) The Russian Arms Race");
			AddMenuItem(menu, "1174", "(Heavy) The Table Tantrum");
		}
	}
	
	AddMenuItem(menu, "30816", "(All) Second Rate Sorcery");
	AddMenuItem(menu, "30621", "(All) Burstchester");
	AddMenuItem(menu, "1118", "(All) Conga");
	AddMenuItem(menu, "438", "(All) Director's Vision");
	AddMenuItem(menu, "1107", "(All) Flippin' Awesome");
	AddMenuItem(menu, "167", "(All) High Five");
	AddMenuItem(menu, "1157", "(All) Kazotsky Kick");
	AddMenuItem(menu, "1162", "(All) Mannrobics");
	AddMenuItem(menu, "1110", "(All) Rock Paper Scissors");
	AddMenuItem(menu, "463", "(All) Schadenfreude");
	AddMenuItem(menu, "1015", "(All) Shred Alert");
	AddMenuItem(menu, "1111", "(All) Skullcracker");
	AddMenuItem(menu, "1106", "(All) Square Dance");
	AddMenuItem(menu, "31162", "(All) The Fist Bump");
	AddMenuItem(menu, "1172", "(All) The Victory Lap");
	AddMenuItem(menu, "1182", "(All) Yeti Punch");
	AddMenuItem(menu, "1183", "(All) Yeti Smash");
	AddMenuItem(menu, "30672", "(All) Zoomin' Broom");
	
	DisplayMenu(menu, client, 20);
}

public Tauntme_MenuSelected(Handle:menu, MenuAction:action, iClient, param2)
{
	if(action == MenuAction_End)
	{
		CloseHandle(menu);
	}
	
	if(action == MenuAction_Select)
	{
		decl String:info[12];
		
		GetMenuItem(menu, param2, info, sizeof(info));
		ExecuteTaunt(iClient, StringToInt(info));
	}
}

ExecuteTaunt(client, itemdef)
{
	static Handle:hItem;
	hItem = TF2Items_CreateItem(OVERRIDE_ALL|PRESERVE_ATTRIBUTES|FORCE_GENERATION);
	
	TF2Items_SetClassname(hItem, "tf_wearable_vm");
	TF2Items_SetQuality(hItem, 6);
	TF2Items_SetLevel(hItem, 1);
	TF2Items_SetNumAttributes(hItem, 0);
	TF2Items_SetItemIndex(hItem, itemdef);
	
	new ent = TF2Items_GiveNamedItem(client, hItem);
	new Address:pEconItemView = GetEntityAddress(ent) + Address:FindSendPropInfo("CTFWearable", "m_Item");
	
	SDKCall(hPlayTaunt, client, pEconItemView) ? 1 : 0;
	AcceptEntityInput(ent, "Kill");
}