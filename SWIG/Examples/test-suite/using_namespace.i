%module using_namespace


%inline %{
  namespace hello
  {  
    struct Hello 
    {
    };

    template <class _T1, class _T2>
    struct Hi : _T1, _T2
    {
      int value1() const
      {
	return 1;
      }      
    };    
  }

  namespace hi
  {

    struct hi0
    {
    };
    
  }
%}

namespace hello
{
  %template(Hi_hi0) Hi<hello::Hello, hi::hi0>;
}


%inline %{
  namespace hi
  {
    struct hi1 : private hello::Hi< hello::Hello, hi0 >
    {
      // This works
      // using hello::Hi< hello::Hello, hi::hi0 >::value1;

      // This doesn't
      using hello::Hi< hello::Hello, hi0 >::value1;

    };
    
  }
  
%}
