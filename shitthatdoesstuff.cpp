/*
#include <iostream>
#include <fstream>
#include <unistd.h>
#include <pwd.h>
#include <sys/types.h>

struct passwd *getpwuid(uid_t uid){
char *pw_name; //user/login name
char *pw_passwd; //password encryption
uid_t pw_uid; //user id
gid_t pw_gid; //group id
time_t pw_change; //time of password change
char *pw_class; //user access class
char *pw_gecos; //user's full name
char *pw_dir; // user's login directory
char *pw_shell; //user's login shell
time_t pw_expire; //time of password expiration
};
int getpwuid_r(uid_t uid, struct passwd *pwd, char *buf, size_t buflen, struct passwd **res);

struct group *getgrgid(uid_t uid){
char *gr_name; //group name
char *gr_passwd; //password encryption
gid_t gr_gid; //group id
char *gr_mem; // list of group memebers
};
int getgrgid_r( gid_t uid, struct group *grp, char*buf, size_t buflen, struct group **res);

int main (int argc, char*argv[])


{
	//uid_t id = 0;
	//struct passwd *pwd;
	//pwd = getpwuid(id);
	//std::cout << pwd << "\n"; 		
	
	//struct stat s;
	struct passwd *pwd;
	struct group *grp;
	int id = 0;
	
	if ((pwd = getpwuid(id)) == NULL) {
		perror("ERROR");
	}
	std::cout << pwd-> pw_name << "\n";
	std::string line;
	//get the user name 
	//std::string user =
	std::ifstream config("/home/user/.config/bdayrmndr/.bdayrmndrc");
	if (config.is_open())
	{
		while(getline(config,line))
		{
			std::cout << line << "\n";
		}	
		config.close();
	}
	else std::cout << "Unable to open file\n";
	return 0;
}
*/
#include <iostream>
#include <fstream>
#include <unistd.h>
#include <cstdlib> //if in the case of using system
int main (int argc, char* argv)
{
/*
std::string line;
std::ifstream config ("~
/Documents/Birthday_Reminder/validation.sh");
if (config.is_open())
{
	while (getline (config, line))
	{
		std::cout << line << "\n";
	}
	config.close();
}
else std::cout << "You can't see shit\n";
*/
//system("cat ~/.config/bdayrmndr/.bdayrmndrc");
FILE *fp = popen("cat ~/.config/bdayrmndr/.bdayrmndrc", "r");
char buf [1024];
int i = 0;

while (fgets(buf, 1024, fp)) {
	if (buf[i] == "22-22-2222")
	{
		std::cout << "holy shit\n";
	}
	i++;
}

fclose(fp);
return 0;
}

