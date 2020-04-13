import { async, ComponentFixture, TestBed } from '@angular/core/testing';

import { ColorizerComponent } from './colorizer.component';

describe('ColorizerComponent', () => {
  let component: ColorizerComponent;
  let fixture: ComponentFixture<ColorizerComponent>;

  beforeEach(async(() => {
    TestBed.configureTestingModule({
      declarations: [ ColorizerComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(ColorizerComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
