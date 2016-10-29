package component.complex;
import api.react.React;
import api.react.ReactComponent;
import api.react.ReactComponent.ReactComponentOfProps;
import component.basic.PreviewView;
import component.complex.ComplexEasingSelectView;
import component.basic.GraphView;
import component.simple.SimpleEasingView;
import component.unary.UnaryOpView;
import core.GlobalContext;
import component.complex.ComplexEasingId;
import tweenxcore.expr.ComplexEasingKind;

class ComplexEasingView extends ReactComponentOfProps<ComplexEasingProps>
{
	public function new(props:ComplexEasingProps) 
	{
		super(props);
	}
	
	override public function render():ReactComponent 
	{
		return React.createElement(
			"div",
			{ className: "complex-easing" },
			React.createElement(
				"div",
				{ className: "complex-easing-head" },
				GraphView.createElement(
					{
						lines: [
							{ easing: props.easing, color: GraphColor.Theme }
						]
					}
				),
				React.createElement(
					"div",
					{ className: "complex-easing-child" },
					PreviewView.createElement(props),
					ComplexEasingSelectView.createElement(props),
					switch (props.easing)
					{
						case ComplexEasingKind.Simple(kind):
							SimpleEasingView.createElement(
								{ 
									kind: kind,
									id: props.id,
									context: props.context,
								}
							);
							
						case ComplexEasingKind.Op(easing, op):
							UnaryOpView.createElement(
								{ 
									easing: easing,
									op: op,
									id: props.id,
									context: props.context,
								}
							);
					}
				)
			)
		);
	}
	
}

typedef ComplexEasingProps =
{
	easing: ComplexEasingKind,
	id: ComplexEasingId,
	context: GlobalContext
}
