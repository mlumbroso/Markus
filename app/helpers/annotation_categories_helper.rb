require 'fastercsv'
require 'ya2yaml'


module AnnotationCategoriesHelper

  def prepare_for_conversion(annotation_categories)
    result = {}
    annotation_categories.each do |annotation_category|
      annotation_texts = []
      annotation_category.annotation_texts.each do |annotation_text|
        annotation_texts.push(annotation_text.content)
      end
      result[annotation_category.annotation_category_name] = annotation_texts
    end
    return result
  end
  
  def convert_to_csv(annotation_categories)
    annotation_categories = prepare_for_conversion(annotation_categories)
    csv_out = FasterCSV.generate do |csv|
       annotation_categories.each do |annotation_category_name, annotation_texts|
         # csv format is user_name,last_name,first_name
         csv << annotation_texts.unshift(annotation_category_name)
       end
     end
     return csv_out
  end
  
  def convert_to_yml(annotation_categories)
    return prepare_for_conversion(annotation_categories).ya2yaml
  end

  def allow_mathml(annotation_text)
    tags = %w(abs and annotation annotation-xml apply approx arccos arccosh arccot arccoth arccsc arccsch arcsec arcsech arcsin arcsinh arctan arctanh arg bind bvar card cartesianproduct cbytes ceiling cerror ci cn codomain complexes compose condition conjugate cos cosh cot coth cs csc csch csymbol curl declare degree determinant diff divergence divide domain domainofapplication el emptyset eq equivalent eulergamma exists exp exponentiale factorial factorof false floor fn forall gcd geq grad gt ident image imaginary imaginaryi implies in infinity int integers intersect interval inverse lambda laplacian lcm leq limit list ln log logbase lowlimit lt maction malign maligngroup malignmark malignscope math matrix matrixrow max mean median menclose merror mfenced mfrac mfraction mglyph mi min minus mlabeledtr mlongdiv mmultiscripts mn mo mode moment momentabout mover mpadded mphantom mprescripts mroot mrow ms mscarries mscarry msgroup msline mspace msqrt msrow mstack mstyle msub msubsup msup mtable mtd mtext mtr munder munderover naturalnumbers neq none not notanumber note notin notprsubset notsubset or otherwise outerproduct partialdiff pi piece piecewise plus power primes product prsubset quotient rationals real reals reln rem root scalarproduct sdev sec sech selector semantics sep set setdiff share sin sinh subset sum tan tanh tendsto times transpose true union uplimit variance vector vectorproduct xor)
    attributes = %w(accent accentunder actiontype align alignmentscope alt altimg altimg-height altimg-valign altimg-width background base cd cdgroup charalign close closure color columnalign columnalignment columnlines columnspacing columnspan columnwidth crossout decimalpoint definitionURL depth dir dir='rtl' display displaystyle edge encoding fence fontfamily fontstyle form frame framespacing groupalign height href id indentalign indentalignfirst indentalignlast indentshift indentshiftfirst indenttarget index integer largeop length linebreak linebreakmultchar linebreakstyle linethickness location longdivstyle lspace ltr mathbackground mathcolor mathsize mathvariant maxsize mediummathspace minlabelspacing minsize monospaced movablelimits msgroup my:background my:color name negativemediummathspace negativethickmathspace negativethinmathspace negativeverythickmathspace negativeverythinmathspace negativeveryverythickmathspace negativeveryverythinmathspace newline notation number open order other overflow position role rowalign rowlines rowspacing rowspan rspace schemaLocation scriptlevel scriptminsize scriptsize scriptsizemultiplier selection separator separators shift side src stackalign stretchy symmetric thickmathspace thinmathspace type verythickmathspace verythinmathspace veryverythickmathspace veryverythinmathspace voffset width xlink:href xml:lang xml:space xmlns xref)
      math_content = sanitize(annotation_text,:tags => tags, :attributes => attributes)
      return math_content 
  end

end
