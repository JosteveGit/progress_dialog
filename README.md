# progress_dialog
Progress Dialog is an open source package with a customizable and easy to use and tweak Progress Dialog

## Widgets
 *  `ProgressDilaog` - Creates a Progess Dialog for you

## Examples
### 1.  Simple use
```
class Home extends StatelessWidget {  
  @override  
  Widget build(BuildContext context) {  
    return Center(  
      child: RaisedButton(  
        onPressed: (){  
          ProgressDialog(context: context).show(message: "Loading...");  
        },  
      ),  
    );  
  }  
}
```
### 2.  With Title and styles.
```
 class Home extends StatelessWidget {  
 @override  
  Widget build(BuildContext context) {  
    return Center(  
      child: RaisedButton(  
        onPressed: () {  
          ProgressDialog(context: context).show(  
            message: "Please wait...",  
            title: "Fetching Data",  
            centerTile: true,  
            titleStyle: TextStyle(fontSize: 40, color: Colors.orange[900]),  
            messageStyle: TextStyle(fontSize: 20, color: Colors.green)  
          );  
        },  
      ),  
    );  
  }  
}
```
### 3. Dismissing the dialog after 10 seconds
```
 class Home extends StatelessWidget {  
  @override  
  Widget build(BuildContext context) {  
    return Center(  
      child: RaisedButton(  
        onPressed: () {  
          ProgressDialog dialog = ProgressDialog(context: context)..show(  
            message: "Please wait...",  
            title: "Fetching Data",  
            centerTile: true,  
            titleStyle: TextStyle(fontSize: 40, color: Colors.orange[900]),  
            messageStyle: TextStyle(fontSize: 20, color: Colors.green)  
          );  
          Timer(Duration(seconds: 10), (){dialog.dismiss();});  
        },  
      ),  
    );  
  }  
}
```
## Contributors
[Josteve Adekanbi](https://github.com/JosteveGit)

